local M = {}
function M.populate_qflist_from_phpcs(opts)
    local target = (opts.args ~= "" and opts.args) or "app"
    local cmd = string.format("./vendor/bin/phpcs -d memory_limit=10G --report=json %s", target)
    -- local cmd = "./vendor/bin/phpcs -d memory_limit=10G --report=json app/"
    local json_output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 and json_output == "" then
        vim.notify("phpcs failed or returned nothing", vim.log.levels.ERROR)
        return
    end
    local ok, data = pcall(vim.fn.json_decode, json_output)
    if not ok then
        local errMsg = string.format("Failed to parse phpcs JSON output %s", json_output)
        vim.notify(errMsg, vim.log.levels.ERROR)
        return
    end
    local qf_items = {}
    for filename, filedata in pairs(data.files or {}) do
        for _, msg in ipairs(filedata.messages or {}) do
            table.insert(qf_items, {
                filename = filename,
                lnum = msg.line,
                col = msg.column,
                text = msg.message,
                type = msg.type:sub(1, 1), -- 'E' or 'W'
            })
        end
    end
    vim.fn.setqflist({}, " ", {
        title = "PHPCS Diagnostics",
        items = qf_items,
    })
    vim.cmd("copen")
end

local function get_git_files()
    local command = [[
{
  git diff --name-only
  git diff --name-only --cached
  git ls-files --others --exclude-standard
} | sort | uniq
]]
    local output = vim.fn.systemlist(command)
    local files = {}
    for _, file in ipairs(output) do
        files[vim.fn.fnamemodify(file, ":p")] = true
    end
    return files
end

function M.populate_qflist_git_files()
    local staged_files = get_git_files()
    local qf_items = {}

    for staged_file in pairs(staged_files) do
        table.insert(qf_items, {
            filename = staged_file,
            lnum = 1,
            col = 1,
        })
    end
    vim.fn.setqflist({}, " ", { title = "Git Files", items = qf_items })
    vim.cmd("copen")
end

return M
