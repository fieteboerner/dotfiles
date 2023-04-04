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

    local lsp_mappings = {
        n = {
            ["<leader>ld"] = { vim.diagnostic.open_float, desc = "Hover diagnostics" },
            ["[d"] = { vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
            ["]d"] = { vim.diagnostic.goto_next, desc = "Next diagnostic" },
            ["gl"] = { vim.diagnostic.open_float, desc = "Hover diagnostics" },

            ["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" },
            ["<leader>lI"] = { "<cmd>NullLsInfo<cr>", desc = "Null-ls information" },

            ["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" },
            ["gD"] = { vim.lsp.buf.declaration, desc = "Declaration of current symbol" },
            ["gd"] = { vim.lsp.buf.definition, desc = "Show the definition of current symbol" },
            ["K"] = { vim.lsp.buf.hover, desc = "Hover symbol details" },
            ["gI"] = { vim.lsp.buf.implementation, desc = "Implementation of current symbol" },
            ["gr"] = { vim.lsp.buf.references, desc = "References of current symbol" },
            ["<leader>lR"] = { vim.lsp.buf.references, desc = "References of current symbol" },
            ["<F2>"] = { vim.lsp.buf.rename, desc = "Rename current Symbol" },
            ["<leader>lr"] = { vim.lsp.buf.rename, desc = "Rename current Symbol" },
            ["<leader>lh"] = { vim.lsp.buf.signature_help, desc = "Signature help" },
            ["gT"] = { vim.lsp.buf.type_definition, desc = "Definition of current type" },
            ["<leader>lG"] = { vim.lsp.buf.workspace_symbol, desc = "Search workspace symbols" },

            ["<leader>lf"] = { function() vim.lsp.buf.format({ async = true }) end, desc = "Format file with LSP" },
        },
        v = {
            ["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" },
        },
    }

    lsp_mappings.n.gd[1] = require("telescope.builtin").lsp_definitions
    lsp_mappings.n.gI[1] = require("telescope.builtin").lsp_implementations
    lsp_mappings.n.gr[1] = require("telescope.builtin").lsp_references
    lsp_mappings.n["<leader>lR"][1] = require("telescope.builtin").lsp_references
    lsp_mappings.n.gT[1] = require("telescope.builtin").lsp_type_definitions
    lsp_mappings.n["<leader>lG"][1] = require("telescope.builtin").lsp_workspace_symbols

    if not vim.tbl_isempty(lsp_mappings.v) then
        lsp_mappings.v["<leader>l"] = { desc = (vim.g.icons_enabled and " " or "") .. "LSP" }
    end
    require("flitzfiete.utils").set_mappings(lsp_mappings, { buffer = bufnr })
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
