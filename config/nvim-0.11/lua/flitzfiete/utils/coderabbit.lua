-- keep `snippets` somewhere accessible (module/global) to show later
_G.CR_SNIPPETS = {}

-- Spinner utility
local function spinner_frames()
    return { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
end

local function start_spinner(msg)
    local frames = spinner_frames()
    local i = 1
    local ns = nil
    -- local ns = vim.notify(msg .. " " .. frames[i], vim.log.levels.INFO, { timeout = false })
    local timer = vim.loop.new_timer()
    timer:start(
        80,
        80,
        vim.schedule_wrap(function()
            i = (i % #frames) + 1
            vim.print("Coderabbit is cooking", frames[i])
            -- ns = vim.notify(msg .. " " .. frames[i], vim.log.levels.INFO, {
            --     replace = ns,
            --     timeout = false,
            -- })
        end)
    )
    return function(final_msg, level)
        timer:stop()
        timer:close()
        vim.notify(final_msg, level or vim.log.levels.INFO, { replace = ns, timeout = 1500 })
    end
end

local function getSnippetKey(f, l)
    return string.format("%s:%d", f or "", tonumber(l) or 1)
end

local function norm_abs(p)
    if not p or p == "" then return "" end
    p = vim.fn.fnamemodify(p, ":p")
    p = vim.loop.fs_realpath(p) or p
    return p:gsub("\\", "/")
end

local function git_root()
    local r = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if r and r ~= "" then
        r = norm_abs(r)
    else
        r = norm_abs(vim.loop.cwd())
    end
    return r
end

-- Parse CodeRabbit plain output into "file:line:col: message" lines
-- Returns:
--   qf_items: { { filename=<abs>, lnum=..., col=1, text="<rel>: <msg>" }, ... }
--   snippets: { ["ABS:line"] = "<full section>", ... }
local function parse_coderabbit_plain(out)
    local items, snippets = {}, {}

    local file_abs, line
    local msg_first = nil
    local in_comment = false
    local section_lines = {}

    local function key(f, l)
        return string.format("%s:%d", norm_abs(f or ""), tonumber(l) or 1)
    end

    local function flush()
        if file_abs and line then
            local msg = (msg_first or "CodeRabbit issue"):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
            table.insert(items, {
                filename = norm_abs(file_abs),
                lnum = tonumber(line) or 1,
                col = 1,
                text = string.format("%s", msg),
            })
            snippets[key(file_abs, line)] = table.concat(section_lines, "\n")
        end
        file_abs, line, msg_first, in_comment = nil, nil, nil, false
        section_lines = {}
    end

    for raw in out:gmatch("([^\r\n]*)\r?\n?") do
        local l = raw or ""

        local f = l:match("^File:%s*(.+)$")
        if f then
            flush()
            if f:match("^/") or f:match("^%a:[/\\]") then
                file_abs = norm_abs(f)
            else
                local root = git_root()
                file_abs = norm_abs(root .. "/" .. f)
            end
            section_lines = {}
        end

        if file_abs then
            table.insert(section_lines, l)
        end

        if not f then
            local ln = l:match("^Line:%s*(%d+)")
            if ln then
                line = ln
            elseif l:match("^Comment:%s*$") then
                in_comment = true
                msg_first = nil
            elseif l:match("^Apply this diff:") then
                in_comment = false
            elseif in_comment and not msg_first then
                local t = l:gsub("^%s+", ""):gsub("%s+$", "")
                if t ~= "" then msg_first = t end
            end
        end
    end

    flush()
    return items, snippets
end


local M = {}
function M.show_current_snippet()
    local info = vim.fn.getqflist({ idx = 0, items = 1 })
    local idx = info.idx or 0

    if idx == 0 then return end

    local items = vim.fn.getqflist()
    local it = items[idx]
    local key = getSnippetKey(vim.api.nvim_buf_get_name(it.bufnr), it.lnum)
    local text = _G.CR_SNIPPETS and _G.CR_SNIPPETS[key]
    if not text then
        vim.notify("No snippet for this item " .. key, vim.log.levels.WARN)
        return
    end

    -- simple float
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = {}
    for s in (text .. "\n"):gmatch("([^\n]*)\n") do table.insert(lines, s) end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("filetype", "coderabbit", { buf = buf })

    local width = math.min(120, math.max(60, 1, vim.iter(lines):fold(1, function(m, s) return math.max(m, #s) end)))
    local height = math.min(30, math.max(8, #lines))
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
    })
end

function M.setup()
    vim.api.nvim_create_user_command("CodeRabbitShow", M.show_current_snippet, {})
    vim.api.nvim_create_user_command("CodeRabbitReview", function()
        local done = start_spinner("CodeRabbit reviewing")
        local output = {}
        local errout = {}

        local handle
        handle = vim.fn.jobstart({ "coderabbit", "--plain" }, {
            stdout_buffered = true,
            stderr_buffered = true,
            on_stdout = function(_, data)
                if data and #data > 0 then
                    table.insert(output, table.concat(data, "\n"))
                end
            end,
            on_stderr = function(_, data)
                if data and #data > 0 then
                    table.insert(errout, table.concat(data, "\n"))
                end
            end,
            on_exit = function(_, code)
                vim.schedule(function()
                    if code ~= 0 then
                        local err = table.concat(errout, "\n")
                        done("CodeRabbit failed" .. (err ~= "" and (": " .. err) or ""), vim.log.levels.ERROR)
                        return
                    end

                    local out = table.concat(output, "\n")
                    local qf_items, snippets = parse_coderabbit_plain(out)

                    if #qf_items == 0 then
                        done("CodeRabbit: no issues found", vim.log.levels.INFO)
                        -- Optionally clear quickfix
                        vim.fn.setqflist({}, " ", { title = "CodeRabbit", lines = {} })
                        return
                    end

                    vim.fn.setqflist({}, " ", { title = "CodeRabbit", items = qf_items })
                    _G.CR_SNIPPETS = snippets

                    done("CodeRabbit: " .. tostring(#qf_items) .. " issues", vim.log.levels.INFO)

                    vim.cmd("copen")
                    -- vim.cmd("cc") -- jump to first issue
                end)
            end,
        })

        if handle <= 0 then
            done("Failed to start coderabbit", vim.log.levels.ERROR)
        end
    end, {})
end

-- vim.keymap.set("n", "<leader>cs", show_current_snippet, { desc = "Show current CodeRabbit snippet" })
return M

-- Optional: mappings to navigate
-- vim.keymap.set("n", "]r", ":cnext<CR>", { silent = true, desc = "Next CodeRabbit issue" })
-- vim.keymap.set("n", "[r", ":cprev<CR>", { silent = true, desc = "Prev CodeRabbit issue" })
