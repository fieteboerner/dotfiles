local M = {}

M.setup = function(lspconfig, server, capabilities)
    lspconfig[server].setup({
        capabilities = capabilities,
        init_options = {
        },
    })
end

return M
