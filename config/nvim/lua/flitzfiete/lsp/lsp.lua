local lsp = require("lsp-zero")

require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_uninstalled = "✗",
            package_pending = "⟳",
        },
    },
})

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
    suggest_lsp_servers = true,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = '',
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format({ async = true }) end, {})
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
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)


vim.diagnostic.config({
    virtual_text = true,
    float = {
        source = true,
    }
})

-- load language configuration
require('flitzfiete.lsp.languages.json')
require('flitzfiete.lsp.languages.lua')
require('flitzfiete.lsp.languages.yaml')

lsp.setup()
