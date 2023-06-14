-- see https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/utils/init.lua
local M = {}

function M.get_icon(kind)
    local icon_pack = "icons"
    if not M[icon_pack] then
        M.icons = require("flitzfiete.icons.nerd_font")
        M.text_icons = require("flitzfiete.icons.text")
    end
    return M[icon_pack] and M[icon_pack][kind] or ""
end

--- Merge extended options with a default table of options
-- @param default the default table that you want to merge into
-- @param opts the new options that should be merged with the default table
-- @return the merged table
function M.extend_tbl(default, opts)
    opts = opts or {}
    return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Serve a notification with a title of AstroNvim
-- @param msg the notification body
-- @param type the type of the notification (:help vim.log.levels)
-- @param opts table of nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
    vim.schedule(function() vim.notify(msg, type, M.extend_tbl({ title = "AstroNvim" }, opts)) end)
end

--- Open a URL under the cursor with the current operating system
-- @param path the path of the file to open with the system opener
function M.system_open(path)
    local cmd
    if vim.fn.has "win32" == 1 and vim.fn.executable "explorer" == 1 then
        cmd = { "cmd.exe", "/K", "explorer" }
    elseif vim.fn.has "unix" == 1 and vim.fn.executable "xdg-open" == 1 then
        cmd = { "xdg-open" }
    elseif (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1) and vim.fn.executable "open" == 1 then
        cmd = { "open" }
    end
    if not cmd then M.notify("Available system opening tool not found!", "error") end
    vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand "<cfile>" }), { detach = true })
end

--- Register queued which-key mappings
function M.which_key_register()
    if M.which_key_queue then
        local wk_avail, wk = pcall(require, "which-key")
        if wk_avail then
            for mode, registration in pairs(M.which_key_queue) do
                wk.register(registration, { mode = mode })
            end
            M.which_key_queue = nil
        end
    end
end

--- Table based API for setting keybindings
-- @param map_table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
-- @param base A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
    -- iterate over the first keys for each mode
    base = base or {}
    for mode, maps in pairs(map_table) do
        -- iterate over each keybinding set in the current mode
        for keymap, options in pairs(maps) do
            -- build the options for the command accordingly
            if options then
                local cmd = options
                local keymap_opts = base
                if type(options) == "table" then
                    cmd = options[1]
                    keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
                    keymap_opts[1] = nil
                end
                if not cmd or keymap_opts.name then -- if which-key mapping, queue it
                    if not M.which_key_queue then M.which_key_queue = {} end
                    if not M.which_key_queue[mode] then M.which_key_queue[mode] = {} end
                    M.which_key_queue[mode][keymap] = keymap_opts
                else -- if not which-key mapping, set it
                    vim.keymap.set(mode, keymap, cmd, keymap_opts)
                end
            end
        end
    end
    if package.loaded["which-key"] then M.which_key_register() end -- if which-key is loaded already, register
end

M.lazy_load = function(plugin)
    vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
        callback = function()
            local file = vim.fn.expand "%"
            local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

            if condition then
                vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

                -- dont defer for treesitter as it will show slow highlighting
                -- This deferring only happens only when we do "nvim filename"
                if plugin ~= "nvim-treesitter" then
                    vim.schedule(function()
                        require("lazy").load { plugins = plugin }

                        if plugin == "nvim-lspconfig" then
                            vim.cmd "silent! do FileType"
                            end
                        end, 0)
                    else
                        require("lazy").load { plugins = plugin }
                    end
                end
            end,
        })
    end

    return M
