local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" })
            end,
        }),
        diagnostics.yamllint,
        diagnostics.trail_space.with({ disabled_filetypes = { "NvimTree" } }),
        diagnostics.stylelint.with({
            filetypes = { "scss", "less", "css", "sass", "vue" },
        }),
        formatting.stylelint.with({
            filetypes = { "scss", "less", "css", "sass", "vue" },
        }),

        -- eslint before prettier because prettier is responsible for the basics (indentation, etc.)
        formatting.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" })
            end,
        }),
        formatting.prettierd.with({
            condition = function(utils)
                return utils.has_file({ ".prettierrc", ".prettierrc.js" })
            end,
            filetypes = {
                "html",
                "json",
                "svelte",
                "markdown",
                "css",
                "javascript",
                "javascriptreact",
                "typescript",
                "vue",
            },
        }),
        formatting.yamlfmt,
        -- formatting.gofmt,
        formatting.goimports,
        formatting.stylua,
    },
})
