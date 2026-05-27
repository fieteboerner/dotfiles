local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                configNamespace = "typescript",
            },
        },
    },
}
