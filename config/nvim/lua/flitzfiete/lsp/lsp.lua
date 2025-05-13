local get_icon = require("flitzfiete.utils").get_icon

local M = {}

function setupUI()
    local get_icon = require("flitzfiete.utils").get_icon

    -- setup ui
    local border = "rounded"
    vim.diagnostic.config({
        virtual_text = true,
        signs = {
            text = {
                [vim.diagnostic.severity.HINT] = get_icon("DiagnosticHint"),
                [vim.diagnostic.severity.INFO] = get_icon("DiagnosticInfo"),
                [vim.diagnostic.severity.WARN] = get_icon("DiagnosticWarn"),
                [vim.diagnostic.severity.ERROR] = get_icon("DiagnosticError"),
            },
        },
        float = {
            border = border,
            source = true,
        },
    })
    if vim.o.signcolumn == "auto" then
        vim.opt.signcolumn = "yes"
    end

    vim.o.winborder = border
end

M.setup = function()
    setupUI()

    local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_cmds,
        desc = "LSP actions",
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require("flitzfiete.keymaps").setupLspMappings(nil, bufnr)
            require("flitzfiete.lsp.format").on_attach(client, bufnr)
            -- require("lsp_signature").on_attach(nil, bufnr)

            if client and client.name == "volar" then
                client.server_capabilities.documentformattingprovider = false
                client.server_capabilities.documentrangeformattingprovider = false
            end
        end
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
    vim.diagnostic.config({
        float = {
            source = true,
        },
    })
end

M.masonLspconfigOptions = function()
    local handlers = {
        -- default handler
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
    })

    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
        ensure_installed = {
            "ts_ls",
            "gopls",
            "lua_ls",
            "yamlls",
            "jsonls",
            "html",
            "cssls",
            "svelte",
            "volar",
            "tailwindcss",
        },
        handlers = {
            function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            lua_ls = function(server)
                require("flitzfiete.lsp.languages.lua").setup(lspconfig, server, lsp_capabilities)
            end,
            jsonls = function(server)
                require("flitzfiete.lsp.languages.json").setup(lspconfig, server, lsp_capabilities)
            end,
            intelephense = function(server)
                require("flitzfiete.lsp.languages.php").setup(lspconfig, server, lsp_capabilities)
            end,
            tailwindcss = function(server)
                require("flitzfiete.lsp.languages.tailwind").setup(lspconfig, server, lsp_capabilities)
            end,
            yamlls = function(server)
                require("flitzfiete.lsp.languages.yaml").setup(lspconfig, server, lsp_capabilities)
            end,
            ts_ls = function(server)
                require("flitzfiete.lsp.languages.typescript").setup(lspconfig, server, lsp_capabilities)
            end,
        },
    })
end

return M
