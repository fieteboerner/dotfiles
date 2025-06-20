vim.opt.autoread = true -- read files fi changed from file system
vim.opt.encoding = "utf-8" --
vim.opt.ruler = true -- show cursor position all the time
vim.opt.cmdheight = 2 -- more space for messages
vim.opt.mouse = "a" -- enable mouse in all modes
vim.opt.number = true
vim.opt.signcolumn = "yes:2" -- always displays the sign column
vim.opt.cursorline = true -- highlight current line
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 1000 -- 1000 is the default
vim.opt.scrolloff = 2 -- minimum lines above/below
vim.opt.formatoptions = "jql"

-- command line --
vim.opt.wildmode = "longest:full,full"
vim.opt.hidden = true
vim.opt.showcmd = true

-- tab stops --
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- line wrapping --
vim.opt.wrap = false
vim.opt.wrapmargin = 8
vim.opt.linebreak = true
vim.opt.showbreak = "…"

--
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- show invisible characters --
vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = "▸ ", trail = "·" }

-- search --
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

vim.opt.termguicolors = true

vim.g.autoformat_enabled = true
vim.g.ui_notifications_enabled = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})
vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})
vim.g.lazygit_floating_window_use_plenary = 1
vim.api.nvim_create_user_command("QfDiagPhpcs", require("flitzfiete.utils.phpcs").populate_qflist_from_phpcs, {})
vim.api.nvim_create_user_command("QfStaged", require("flitzfiete.utils.phpcs").populate_qflist_git_files, {})
