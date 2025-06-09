local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local projectConfig = {
    _init = false,
    eslintFile = nil,
    prettierFile = nil,
}
function getProjectConfig()
    if not projectConfig._init then
        local f = io.open(".nvim.project", "r")
        if not f then
            projectConfig._init = true
            return projectConfig
        end
        f:close()
        local conf = dofile(".nvim.project")
        if conf and conf.eslintFile then
            projectConfig.eslintFile = conf.eslintFile
        end
        if conf and conf.prettierFile then
            projectConfig.prettierFile = conf.prettierFile
        end
        projectConfig._init = true
    end
    return projectConfig
end

function should_format_with_prettier(utils)
    return utils.root_has_file({
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.json",
        getProjectConfig().prettierFile,
    })
end

-- local phpcsRuleset = "phpcs.xml"
local phpcsRuleset = nil
function getPhpCsRulesetFile()
    if phpcsRuleset ~= nil then
        return phpcsRuleset
    end

    local ruleset_priority = {
        "phpcs_ruleset.xml",
        "phpcs.xml",
    }

    for _, ruleset in ipairs(ruleset_priority) do
        local ruleset_path = vim.fn.expand(ruleset)
        if vim.fn.filereadable(ruleset_path) == 1 then
            phpcsRuleset = ruleset_path
            break
        end
    end

    return phpcsRuleset or ""
end

null_ls.setup({
    sources = {
        -- diagnostics.eslint_d.with({
        --     condition = function(utils)
        --         return utils.root_has_file({
        --             ".eslintrc.js",
        --             ".eslintrc.cjs",
        --             ".eslintrc.json",
        --             "eslint.config.ts",
        --             "eslint.config.js",
        --             getProjectConfig().eslintFile,
        --         })
        --     end,
        -- }),
        diagnostics.yamllint,
        diagnostics.trail_space.with({ disabled_filetypes = { "NvimTree" } }),
        diagnostics.stylelint.with({
            extra_args = {
                "--quiet-deprecation-warnings",
            },
            condition = function(utils)
                return utils.root_has_file({ "stylelint.config.js", ".stylelintrc.js", ".stylelintrc" })
            end,
            filetypes = { "scss", "less", "css", "sass", "vue" },
        }),
        diagnostics.phpcs.with({
            command = vim.fn.getcwd() .. "/vendor/bin/phpcs",
            condition = function(utils)
                return utils.root_has_file({ "phpcs.xml", "phpcs_ruleset.xml" })
            end,
            extra_args = {
                "--standard=" .. getPhpCsRulesetFile(),
            },
        }),
        formatting.stylelint.with({
            filetypes = { "scss", "less", "css", "sass", "vue" },
        }),

        -- eslint before prettier because prettier is responsible for the basics (indentation, etc.)
        -- formatting.eslint_d.with({
        --     condition = function(utils)
        --         -- do not format with eslint if it should do with prettier
        --         if should_format_with_prettier(utils) then
        --             return false
        --         end
        --         return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
        --     end,
        -- }),
        formatting.prettierd.with({
            condition = function(utils)
                return should_format_with_prettier(utils)
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
        -- formatting.phpcsfixer,
        formatting.phpcbf.with({
            extra_args = {
                "--standard=" .. getPhpCsRulesetFile(),
            },
        }),
        -- formatting.black,
    },
})
