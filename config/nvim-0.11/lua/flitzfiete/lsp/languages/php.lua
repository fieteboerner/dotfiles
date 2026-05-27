local M = {}

M.setup = function(lspconfig, server, capabilities)
    lspconfig[server].setup({
        capabilities = capabilities,
        init_options = {
            licenceKey = "TBD",
        },
    })
end

return M
