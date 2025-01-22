local M = {}

M.setup = function(lspconfig, server, capabilities)
    lspconfig[server].setup({
        capabilities = capabilities,
        settings = {
            yaml = {
                schemas = {
                    kubernetes = "*.yaml",
                },
            },
        },
    })
end

return M
