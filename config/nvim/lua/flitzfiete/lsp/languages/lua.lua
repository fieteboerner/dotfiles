local M = {}

M.setup = function(lspconfig, server, capabilities)
    lspconfig[server].setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.stdpath("data") .. "/lazy/extensions/nvchad_types"] = true,
                        [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

return M
