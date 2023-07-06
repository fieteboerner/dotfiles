local notify = require("flitzfiete.utils").notify

local M = {}

M.format_opts = {}

function M.has_capability(capability, filter)
    for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
        if client.supports_method(capability) then
            return true
        end
    end
    return false
end

local function add_buffer_autocmd(augroup, bufnr, autocmds)
    if not vim.tbl_islist(autocmds) then
        autocmds = { autocmds }
    end
    local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
    if not cmds_found or vim.tbl_isempty(cmds) then
        vim.api.nvim_create_augroup(augroup, { clear = false })
        for _, autocmd in ipairs(autocmds) do
            local events = autocmd.events
            autocmd.events = nil
            autocmd.group = augroup
            autocmd.buffer = bufnr
            vim.api.nvim_create_autocmd(events, autocmd)
        end
    end
end

local function del_buffer_autocmd(augroup, bufnr)
    local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
    if cmds_found then
        vim.tbl_map(function(cmd)
            vim.api.nvim_del_autocmd(cmd.id)
        end, cmds)
    end
end

M.on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
            vim.lsp.buf.format(M.format_opts)
        end, { desc = "Format file with LSP" })

        add_buffer_autocmd("lsp_auto_format", bufnr, {
            events = "BufWritePre",
            desc = "autoformat on save",
            callback = function()
                if not M.has_capability("textDocument/formatting", { bufnr = bufnr }) then
                    del_buffer_autocmd("lsp_auto_format", bufnr)
                    return
                end
                local autoformat_enabled = vim.b.autoformat_enabled
                if autoformat_enabled == nil then
                    autoformat_enabled = true
                end
                if autoformat_enabled then
                    vim.lsp.buf.format(vim.tbl_deep_extend("force", M.format_opts, { bufnr = bufnr }))
                end
            end,
        })
    end
end

function M.toggle_buffer_autoformat()
    local old_val = vim.b.autoformat_enabled
    if old_val == nil then
        old_val = vim.g.autoformat_enabled
    end
    vim.b.autoformat_enabled = not old_val
    notify(string.format("Buffer autoformatting %s", tostring(vim.b.autoformat_enabled)))
end

return M
