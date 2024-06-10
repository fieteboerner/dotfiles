local lsp = require("lsp-zero")
local get_icon = require("flitzfiete.utils").get_icon

local M = {}

M.on_attach = function(client, bufnr)
    require("flitzfiete.keymaps").setupLspMappings(client, bufnr)
    require("flitzfiete.lsp.format").on_attach(client, bufnr)

    -- if client.server_capabilities.signatureHelpProvider then
    --     require("flitzfiete.utils.signature").setup(client)
    -- end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

M.setup = function()
    vim.diagnostic.config({
        float = { border = "single" },
    })
    lsp.preset({
        float_border = "rounded",
    })

    lsp.ensure_installed({
        "tsserver",
        "gopls",
        "lua_ls",
        "yamlls",
        "jsonls",
        "html",
        "cssls",
        "svelte",
        "volar",
        "tailwindcss",
    })

    lsp.set_preferences({
        suggest_lsp_servers = true,
    })
    lsp.set_sign_icons({
        error = get_icon("DiagnosticError"),
        warn = get_icon("DiagnosticWarn"),
        info = get_icon("DiagnosticInfo"),
        hint = get_icon("DiagnosticHint"),
    })

    lsp.extend_lspconfig({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
    })

    require("flitzfiete.lsp.languages.lua")
    require("flitzfiete.lsp.languages.json")
    require("flitzfiete.lsp.languages.tailwind")
    require("flitzfiete.lsp.languages.php")
    require("flitzfiete.lsp.languages.vue")
    require("flitzfiete.lsp.languages.yaml")

    lsp.setup()
end

M.masonLspconfigOptions = function()
    local handlers = {
        -- default handler
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
    }
    local customHandlers = {
        ["jsonls"] = require("flitzfiete.lsp.languages.json"),
        ["lua_ls"] = require("flitzfiete.lsp.languages.lua"),
        ["intelephense"] = require("flitzfiete.lsp.languages.php"),
        ["tailwindcss"] = require("flitzfiete.lsp.languages.tailwind"),
        ["volar"] = require("flitzfiete.lsp.languages.vue"),
        ["yamlls"] = require("flitzfiete.lsp.languages.yaml"),
    }
    for key, opts in pairs(customHandlers) do
        handlers[key] = function()
            require("lspconfig")[key].setup(opts)
        end
    end
    return {
        ensure_installed = {
            "cssls",
            "gopls",
            "html",
            "jsonls",
            "lua_ls",
            "svelte",
            "tailwindcss",
            "tsserver",
            "volar",
            "yamlls",
        },
        handlers = handlers,
    }
end

return M
