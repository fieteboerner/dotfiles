local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require('telescope').setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix  = "  ",
        file_ignore_patterns = { '.git/' },
        layout_config = {
        prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    },
    pickers = {
        git_files = {
        },
        lsp_references = {
            theme = "dropdown",
            previewer = false,

            -- cache_picker = true
        },
    },

})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
