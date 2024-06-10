local lsp = require("lsp-zero")

lsp.configure("tailwindcss", {
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
