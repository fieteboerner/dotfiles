local M = {}

M.setup = function(lspconfig, server, capabilities)
    -- @see https://lsp-zero.netlify.app/v3.x/guide/configure-volar-v2.html
    -- local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
    --     .. "/node_modules/@vue/language-server"
    --     .. "/node_modules/@vue/typescript-plugin"

    lspconfig[server].setup({
        capabilities = capabilities,
        init_options = {
            plugins = {
                -- {
                --     name = "@vue/typescript-plugin",
                --     location = vue_typescript_plugin,
                --     languages = { "javascript", "typescript", "vue" },
                -- },
            },
        },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            -- "vue",
        },
    })
end

return M
