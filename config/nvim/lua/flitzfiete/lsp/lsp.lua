local lsp = require ("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    -- 'eslint',
    'lua_ls',
    'yamlls',
    'jsonls',
    'html',
    'cssls',
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = '',
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    -- if client.name == "eslint" then
    --     vim.cmd.LspStop('eslint')
    --     return
    -- end
    if client.name == 'gopls' then
        -- client.server_capabilities.document_formatting = false
        -- client.server_capabilities.document_range_formatting = false
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)


vim.diagnostic.config({
    virtual_text = true,
})

-- load language configuration
require('flitzfiete.lsp.languages.json')
require('flitzfiete.lsp.languages.lua')
require('flitzfiete.lsp.languages.yaml')

lsp.setup()
