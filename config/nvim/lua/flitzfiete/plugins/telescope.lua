local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, {})
-- fg = File Git
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- fa = File All
vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({
        prompt_title = 'Find files (all files)',
        file_ignore_patterns = {}
    })
end, {})
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
        file_ignore_patterns = { '.git/', 'node_modules/', 'vendor/' },
        layout_config = {
            prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        mappings = {
            n = {
                ["<esc"] = require('telescope.actions').close,
                ["<Space>"] = require('telescope.actions').select_default,
            }
        },
    },
    pickers = {
        lsp_references = {
            theme = "dropdown",
            previewer = false,
        },
        oldfiles = {
            cwd_only = true,
            on_complete = { function() vim.cmd"stopinsert" end },
        }
    },

})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
