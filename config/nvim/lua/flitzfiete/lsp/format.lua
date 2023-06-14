local M = {}

M.format_opts = {}

function M.has_capability(capability, filter)
  for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
    if client.supports_method(capability) then return true end
  end
  return false
end

M.on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
        vim.api.nvim_buf_create_user_command(
            bufnr,
            "Format",
            function() vim.lsp.buf.format(M.format_opts) end,
            { desc = "Format file with LSP" }
        )


        vim.api.nvim_create_autocmd(
            {"BufWritePre"},
            {
                desc = "autoformat on save",
                callback = function()
                    if not M.has_capability("textDocument/formatting", { bufnr = bufnr }) then
                        -- del_buffer_autocmd("lsp_auto_format", bufnr)
                        return
                    end
                    local autoformat_enabled = vim.b.autoformat_enabled
                    if autoformat_enabled == nil then autoformat_enabled = true end
                    if autoformat_enabled then
                        vim.lsp.buf.format(vim.tbl_deep_extend("force", M.format_opts, { bufnr = bufnr }))
                    end
                end,
            }
        )
    end
end

function M.toggle_buffer_autoformat()
    local old_val = vim.b.autoformat_enabled
    if old_val == nil then old_val = vim.g.autoformat_enabled end
    vim.b.autoformat_enabled = not old_val
    ui_notify(string.format("Buffer autoformatting %s", bool2str(vim.b.autoformat_enabled)))
end

return M
