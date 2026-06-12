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
            "vue_ls",
            "tailwindcss",
        },
        handlers = {
            function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
                -- require("flitzfiete.lsp.languages.vue").setup(lspconfig, server, lsp_capabilities)
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
            volar = function(server)
                -- do nothing
            end,
            eslint = function(server)
                -- necessary to get eslint lsp to work in projects with eslint@10
                -- before_init necessary because nvim-lspconfig sets useFlagConfig internally, so the settings are not enough
                lspconfig.eslint.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        packageManager = "npm",
                        workingDirectories = {
                            { mode = "auto" },
                        },
                        useESLintClass = true,
                        experimental = {
                            useFlatConfig = false,
                        },
                    },
                    before_init = function(_, config)
                        local root_dir = config.root_dir

                        if root_dir then
                            config.settings = config.settings or {}
                            config.settings.workspaceFolder = {
                                uri = root_dir,
                                name = vim.fn.fnamemodify(root_dir, ":t"),
                            }

                            config.settings.useESLintClass = true
                            config.settings.experimental = config.settings.experimental or {}
                            config.settings.experimental.useFlatConfig = false
                        end
                    end,
                })
            end,
            -- ts_ls = function(server)
            --     require("flitzfiete.lsp.languages.typescript").setup(lspconfig, server, lsp_capabilities)
            -- end,
            -- vtsls = function(server)
            --     return
            -- end,
            -- vue_ls = function(server)
            --     require("flitzfiete.lsp.languages.vue").setupVtsls(lspconfig, server, lsp_capabilities)
            --     require("flitzfiete.lsp.languages.vue").setupVueLs(lspconfig, server, lsp_capabilities)
            -- end,
        },
    })
end

return M
