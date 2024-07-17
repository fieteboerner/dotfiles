local lsp = require("lsp-zero")

-- @see https://lsp-zero.netlify.app/v3.x/guide/configure-volar-v2.html
local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
    .. "/node_modules/@vue/language-server"
    .. "/node_modules/@vue/typescript-plugin"
lsp.configure("tsserver", {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_typescript_plugin,
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
    },
})
-- disable autoformatting of volar
lsp.configure("volar", {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})
