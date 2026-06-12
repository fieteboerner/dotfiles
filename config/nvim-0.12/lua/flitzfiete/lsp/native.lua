local M = {}

local function prepend_mason_bin()
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    if not vim.env.PATH:find(mason_bin, 1, true) then
        vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
    end
end

local function setup_ui()
    local get_icon = require("flitzfiete.utils").get_icon
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

local function setup_attach()
    local group = vim.api.nvim_create_augroup("flitzfiete_lsp_native", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            require("flitzfiete.keymaps").setupLspMappings(client, bufnr)
            require("flitzfiete.lsp.format").on_attach(client, bufnr)
        end,
    })
end

local function setup_servers()
    vim.lsp.enable({
        "lua_ls",
        "gopls",
        "jsonls",
        "yamlls",
        "ts_ls",
        "html",
        "cssls",
        "svelte",
        "vue_ls",
        "tailwindcss",
        "eslint",
        "intelephense",
    })
end

function M.setup()
    prepend_mason_bin()
    setup_ui()
    setup_attach()
    setup_servers()
end

return M
