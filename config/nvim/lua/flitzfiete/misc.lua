vim.api.nvim_create_user_command('Format', vim.lsp.buf.format, {})
vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format({ sync = true })]]
