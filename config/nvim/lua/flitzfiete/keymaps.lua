vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move text up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move horizontally
vim.keymap.set('n', '<c-H>', '20zh')
vim.keymap.set('n', '<c-L>', '20zl')

-- center to -
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "Gzzzv")
vim.keymap.set("n", "{", "{zzzv")
vim.keymap.set("n", "}", "}zzzv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete but keep copy buffer
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Disable annoying command line thing
vim.keymap.set('n', 'q:', ':q<CR>')

-- Paste replace visual selection without copying it
-- vim.keymap.set('v', 'p', '"_dP')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")


--

local utils = require("flitzfiete.utils")
local ui = require("flitzfiete.utils.ui")

local maps = { i = {}, n = {}, v = {}, t = {} }
local sections = {
    f = { desc = "󰍉 Find" },
    p = { desc = "󰏖 Packages" },
    l = { desc = " LSP" },
    u = { desc = " UI" },
    b = { desc = "󰓩 Buffers" },
    d = { desc = " Debugger}" },
    g = { desc = " Git" },
    S = { desc = "󱂬 Session" },
    t = { desc = " Terminal" },
}

-- Plugin Manager
maps.n["<leader>p"] = sections.p
maps.n["<leader>pi"] = { function() require("packer").install() end, desc = "Plugins Install" }
maps.n["<leader>ps"] = { function() require("packer").home() end, desc = "Plugins Status" }
maps.n["<leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<leader>pu"] = { function() require("packer").check() end, desc = "Plugins Check Updates" }
maps.n["<leader>pU"] = { function() require("packer").update() end, desc = "Plugins Update" }


-- Telescope
maps.n["<C-P>"] = { function () require("telescope.builtin").find_files() end, desc = "Find files" }
maps.n["<leader>f"] = sections.f
maps.n["<leader>g"] = sections.g
maps.n["<leader>gb"] = { function() require("telescope.builtin").git_branches() end, desc = "Git branches" }
maps.n["<leader>gc"] = { function() require("telescope.builtin").git_commits() end, desc = "Git commits" }
maps.n["<leader>gt"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" }
maps.n["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
maps.n["<leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
maps.n["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
maps.n["<leader>fc"] =
{ function() require("telescope.builtin").grep_string() end, desc = "Find for word under cursor" }
maps.n["<leader>fC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
maps.n["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
maps.n["<leader>fF"] = {
    function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
    desc = "Find all files",
}
maps.n["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
maps.n["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
maps.n["<leader>fm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
maps.n["<leader>fn"] =
{ function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
maps.n["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
maps.n["<leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
maps.n["<leader>ft"] =
{ function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }
maps.n["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
maps.n["<leader>fW"] = {
    function()
        require("telescope.builtin").live_grep {
            additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
        }
    end,
    desc = "Find words in all files",
}
maps.n["<leader>fu"] = { function() vim.cmd.UndoTreeToggle() end, desc = "Undo tree"}
maps.n["<leader>l"] = sections.l
maps.n["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
maps.n["<leader>ls"] = {
    function()
        require("telescope.builtin").lsp_document_symbols()
    end,
    desc = "Search symbols",
}

-- GitSigns
maps.n["<leader>g"] = sections.g
maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }

maps.n["<leader>gg"] = { "<cmd>LazyGit<cr>", desc = "Toggle Explorer" }
maps.n["<leader>gL"] = { function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
maps.n["<leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
maps.n["<leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
maps.n["<leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
maps.n["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
maps.n["<leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
maps.n["<leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
maps.n["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }

-- NeoTree
maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
maps.n["<leader>o"] = {
    function()
        if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
        else
            vim.cmd.Neotree "focus"
        end
    end,
    desc = "Toggle Explorer Focus",
}

-- Custom menu for modification of the user experience
maps.n["<leader>u"] = sections.u
maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "Toggle autopairs" }
maps.n["<leader>ub"] = { ui.toggle_background, desc = "Toggle background" }
maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "Toggle autocompletion" }
maps.n["<leader>uC"] = { "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlight" }
maps.n["<leader>ug"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" }
maps.n["<leader>ui"] = { ui.set_indent, desc = "Change indent setting" }
maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" }
maps.n["<leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens refresh" }
maps.n["<leader>un"] = { ui.change_number, desc = "Change line numbering" }
maps.n["<leader>uN"] = { ui.toggle_ui_notifications, desc = "Toggle UI notifications" }
maps.n["<leader>up"] = { ui.toggle_paste, desc = "Toggle paste mode" }
maps.n["<leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" }
maps.n["<leader>ut"] = { ui.toggle_tabline, desc = "Toggle tabline" }
maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" }
maps.n["<leader>uy"] = { ui.toggle_syntax, desc = "Toggle syntax highlight" }

utils.set_mappings(maps)
