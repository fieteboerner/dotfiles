local lsp = require('lsp-zero')

lsp.configure('yamlls', {
    settings = {
        yaml = {
            schemas = {
                kubernetes = "*.yaml"
            }
        }
    }
})