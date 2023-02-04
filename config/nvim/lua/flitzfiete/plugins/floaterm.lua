vim.keymap.set('n', '<C-J>', ':FloatermToggle scratch<CR>')
vim.keymap.set('t', '<C-J>', '<C-\\><C-n>:FloatermToggle scratch<CR>')

vim.g.floaterm_autoinsert = 1
vim.g.floaterm_wintype = 'split'
vim.g.floaterm_position = 'rightbelow'
vim.g.floaterm_width = 1
vim.g.floaterm_height = 0.4
vim.g.floaterm_wintitle = 0
