local M = {}

M.setup = function(lspconfig, server, capabilities)
    lspconfig[server].setup({
        capabilities = capabilities,
        settings = {
            yaml = {
                -- see for more schemas: https://www.reddit.com/r/neovim/comments/ze9gbe/kubernetes_auto_completion_support_in_neovim/
                schemas = {
                    kubernetes = "*.yaml",
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
                    "*gitlab-ci*.{yml,yaml}",
                },
            },
        },
    })
end

return M
