local root_file_patterns = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
    "package.json",
}

return {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
    },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root_file = vim.fs.find(root_file_patterns, { path = fname, upward = true })[1]

        if root_file then
            on_dir(vim.fs.dirname(root_file))
        end
    end,
    settings = {
        validate = "on",
        packageManager = "npm",
        useESLintClass = true,
        experimental = {
            useFlatConfig = false,
        },
        codeActionOnSave = {
            enable = false,
            mode = "all",
        },
        format = false,
        quiet = false,
        onIgnoredFiles = "off",
        rulesCustomizations = {},
        run = "onType",
        problems = {
            shortenToSingleLine = false,
        },
        nodePath = "",
        workingDirectory = { mode = "auto" },
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine",
            },
            showDocumentation = {
                enable = true,
            },
        },
    },
}
