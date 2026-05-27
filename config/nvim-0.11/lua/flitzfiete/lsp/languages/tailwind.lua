local M = {}

M.setup = function(lspconfig, server, capabilities)
    lspconfig[server].setup({
        capabilities = capabilities,
        filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
        },
        root_dir = require("lspconfig").util.root_pattern("tailwind.config.js", "package.json"),
        settings = {
            tailwindCSS = {
                experimental = {
                    classRegex = {
                        { "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    },
                },
            },
        },
    })
end

return M
