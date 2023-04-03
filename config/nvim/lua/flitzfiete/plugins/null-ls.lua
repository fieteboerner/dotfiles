local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
            end
        }),
        diagnostics.yamllint,
        diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
        -- formatting.eslint,
        formatting.prettier.with({
            filetypes = { "html", "json", "svelte", "markdown", "css", "javascript", "javascriptreact" },
        }),
        formatting.yamlfmt,
        -- formatting.gofmt,
        formatting.goimports,
    },
})
