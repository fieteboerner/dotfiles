require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    filetypes_denylist = {
        'packer',
        'NvimTree',
        'TelescopePrompt',
    },

})
