local lsp = require("lsp-zero")

-- disable autoformatting of volar
lsp.configure("volar", {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})
