require('indent_blankline').setup({
    filetype_exclude = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
    },
    buftype_exclude = {
        'terminal',
    },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
})
