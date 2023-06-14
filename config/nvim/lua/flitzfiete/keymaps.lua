local utils = require("flitzfiete.utils")
local ui = require("flitzfiete.utils.ui")
local formatter = require("flitzfiete.lsp.format")

local M = {}

M.sections = {
    f = { desc = "ó° Find" },
    p = { desc = "ó° Packages" },
    l = { desc = "ï LSP" },
    u = { desc = "î­¿ UI" },
    b = { desc = "ó°© Buffers" },
    d = { desc = "ï Debugger}" },
    g = { desc = "ï¡ Git" },
    S = { desc = "ó±¬ Session" },
    t = { desc = "î Terminal" },
}
M.maps = { i = {}, n = {}, v = {}, t = {} }

-- Plugin Manager
M.maps.n["<leader>p"] = M.sections.p
M.maps.n["<leader>pi"] = {
    function()
        require("packer").install()
    end,
    desc = "Plugins Install",
}
M.maps.n["<leader>ps"] = {
    function()
        require("packer").home()
    end,
    desc = "Plugins Status",
}
M.maps.n["<leader>pS"] = {
    function()
        require("lazy").sync()
    end,
    desc = "Plugins Sync",
}
M.maps.n["<leader>pu"] = {
    function()
        require("packer").check()
    end,
    desc = "Plugins Check Updates",
}
M.maps.n["<leader>pU"] = {
    function()
        require("packer").update()
    end,
    desc = "Plugins Update",
}

-- NeoTree
M.maps.n["<leader>e"] = { "<cmd>Neotree<CR>", desc = "Toggle Explorer" }
M.maps.n["<leader>o"] = { "<cmd>Neotree focus<CR>", desc = "Toggle Explorer Focus" }

-- Oil
M.maps.n["-"] = {
    function()
        require("oil").open()
    end,
    desc = "Open Parent Directory"
}

-- Telescope
M.maps.n["<C-P>"] = {
    function()
        require("telescope.builtin").find_files()
    end,
    desc = "Find files",
}
M.maps.n["<leader>f"] = M.sections.f
M.maps.n["<leader>g"] = M.sections.g
M.maps.n["<leader>gb"] = {
    function()
        require("telescope.builtin").git_branches()
    end,
    desc = "Git branches",
}
M.maps.n["<leader>gc"] = {
    function()
        require("telescope.builtin").git_commits()
    end,
    desc = "Git commits",
}
M.maps.n["<leader>gt"] = {
    function()
        require("telescope.builtin").git_status()
    end,
    desc = "Git status",
}
M.maps.n["<leader>f<CR>"] = {
    function()
        require("telescope.builtin").resume()
    end,
    desc = "Resume previous search",
}
M.maps.n["<leader>f'"] = {
    function()
        require("telescope.builtin").marks()
    end,
    desc = "Find marks",
}
M.maps.n["<leader>fb"] = {
    function()
        require("telescope.builtin").buffers()
    end,
    desc = "Find buffers",
}
M.maps.n["<leader>fc"] = {
    function()
        require("telescope.builtin").grep_string()
    end,
    desc = "Find for word under cursor",
}
M.maps.n["<leader>fC"] = {
    function()
        require("telescope.builtin").commands()
    end,
    desc = "Find commands",
}
M.maps.n["<leader>ff"] = {
    function()
        require("telescope.builtin").find_files()
    end,
    desc = "Find files",
}
M.maps.n["<leader>fF"] = {
    function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
    end,
    desc = "Find all files",
}
M.maps.n["<leader>fh"] = {
    function()
        require("telescope.builtin").help_tags()
    end,
    desc = "Find help",
}
M.maps.n["<leader>fk"] = {
    function()
        require("telescope.builtin").keymaps()
    end,
    desc = "Find keymaps",
}
M.maps.n["<leader>fm"] = {
    function()
        require("telescope.builtin").man_pages()
    end,
    desc = "Find man",
}
M.maps.n["<leader>fn"] = {
    function()
        require("telescope").extensions.notify.notify()
    end,
    desc = "Find notifications",
}
M.maps.n["<leader>fo"] = {
    function()
        require("telescope.builtin").oldfiles()
    end,
    desc = "Find history",
}
M.maps.n["<leader>fr"] = {
    function()
        require("telescope.builtin").registers()
    end,
    desc = "Find registers",
}
M.maps.n["<leader>ft"] = {
    function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
    end,
    desc = "Find themes",
}
M.maps.n["<leader>fw"] = {
    function()
        require("telescope.builtin").live_grep()
    end,
    desc = "Find words",
}
M.maps.n["<leader>fW"] = {
    function()
        require("telescope.builtin").live_grep({
            additional_args = function(args)
                return vim.list_extend(args, { "--hidden", "--no-ignore" })
            end,
        })
    end,
    desc = "Find words in all files",
}
M.maps.n["<leader>fu"] = {
    function()
        vim.cmd.UndoTreeToggle()
    end,
    desc = "Undo tree",
}

-- GitSigns
M.maps.n["<leader>g"] = M.sections.g
M.maps.n["]g"] = {
    function()
        require("gitsigns").next_hunk()
    end,
    desc = "Next Git hunk",
}
M.maps.n["[g"] = {
    function()
        require("gitsigns").prev_hunk()
    end,
    desc = "Previous Git hunk",
}

M.maps.n["<leader>gg"] = { "<cmd>LazyGit<cr>", desc = "Toggle Explorer" }
M.maps.n["<leader>gL"] = {
    function()
        require("gitsigns").blame_line({ full = true })
    end,
    desc = "View full Git blame",
}
M.maps.n["<leader>gp"] = {
    function()
        require("gitsigns").preview_hunk()
    end,
    desc = "Preview Git hunk",
}
M.maps.n["<leader>gh"] = {
    function()
        require("gitsigns").reset_hunk()
    end,
    desc = "Reset Git hunk",
}
M.maps.n["<leader>gr"] = {
    function()
        require("gitsigns").reset_buffer()
    end,
    desc = "Reset Git buffer",
}
M.maps.n["<leader>gs"] = {
    function()
        require("gitsigns").stage_hunk()
    end,
    desc = "Stage Git hunk",
}
M.maps.n["<leader>gS"] = {
    function()
        require("gitsigns").stage_buffer()
    end,
    desc = "Stage Git buffer",
}
M.maps.n["<leader>gu"] = {
    function()
        require("gitsigns").undo_stage_hunk()
    end,
    desc = "Unstage Git hunk",
}
M.maps.n["<leader>gd"] = {
    function()
        require("gitsigns").diffthis()
    end,
    desc = "View Git diff",
}

-- NeoTree
M.maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
M.maps.n["<leader>o"] = {
    function()
        if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd("p")
        else
            vim.cmd.Neotree("focus")
        end
    end,
    desc = "Toggle Explorer Focus",
}

-- Custom menu for modification of the user experience
M.maps.n["<leader>u"] = M.sections.u
M.maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "Toggle autopairs" }
M.maps.n["<leader>ub"] = { ui.toggle_background, desc = "Toggle background" }
M.maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "Toggle autocompletion" }
M.maps.n["<leader>uC"] = { "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlight" }
M.maps.n["<leader>ug"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" }
M.maps.n["<leader>ui"] = { ui.set_indent, desc = "Change indent setting" }
M.maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" }
M.maps.n["<leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens refresh" }
M.maps.n["<leader>un"] = { ui.change_number, desc = "Change line numbering" }
M.maps.n["<leader>uN"] = { ui.toggle_ui_notifications, desc = "Toggle UI notifications" }
M.maps.n["<leader>up"] = { ui.toggle_paste, desc = "Toggle paste mode" }
M.maps.n["<leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
M.maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" }
M.maps.n["<leader>ut"] = { ui.toggle_tabline, desc = "Toggle tabline" }
M.maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" }
M.maps.n["<leader>uy"] = { ui.toggle_syntax, desc = "Toggle syntax highlight" }
M.maps.n["<leader>uf"] = { formatter.toggle_buffer_autoformat, desc = "Toggle buffer auto formatting" }

M.setup = function()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- move text up/down
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- move horizontally
    vim.keymap.set("n", "<c-H>", "20zh")
    vim.keymap.set("n", "<c-L>", "20zl")

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
    vim.keymap.set("n", "<leader>y", '"+y')
    vim.keymap.set("v", "<leader>y", '"+y')
    vim.keymap.set("n", "<leader>Y", '"+Y')

    -- delete but keep copy buffer
    vim.keymap.set("n", "<leader>d", '"_d')
    vim.keymap.set("v", "<leader>d", '"_d')

    -- Disable annoying command line thing
    vim.keymap.set("n", "q:", ":q<CR>")

    -- Paste replace visual selection without copying it
    -- vim.keymap.set('v', 'p', '"_dP')

    -- Maintain the cursor position when yanking a visual selection
    -- http://ddrscott.github.io/blog/2016/yank-without-jank/
    vim.keymap.set("v", "y", "myy`y")
    vim.keymap.set("v", "Y", "myY`y")

    -- Move text up and down
    vim.keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi")
    vim.keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi")
    vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
    vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

    -- fix home key
    vim.keymap.set("", "<Home>", "^")
    vim.keymap.set("i", "<Home>", "<Esc>^i")

    utils.set_mappings(M.maps)
end
--
--
M.setupLspMappings = function(client, bufnr)
    local lsp_mappings = {
        n = {
            ["<leader>l"] = M.sections.l,
            ["<leader>ld"] = { vim.diagnostic.open_float, desc = "Hover diagnostics" },
            ["[d"] = { vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
            ["]d"] = { vim.diagnostic.goto_next, desc = "Next diagnostic" },
            ["gl"] = { vim.diagnostic.open_float, desc = "Hover diagnostics" },

            ["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" },
            ["<leader>lI"] = { "<cmd>NullLsInfo<cr>", desc = "Null-ls information" },

            ["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" },
            ["gD"] = { vim.lsp.buf.declaration, desc = "Declaration of current symbol" },
            ["gd"] = { vim.lsp.buf.definition, desc = "Show the definition of current symbol" },
            ["K"] = { vim.lsp.buf.hover, desc = "Hover symbol details" },
            ["gI"] = { vim.lsp.buf.implementation, desc = "Implementation of current symbol" },
            ["gr"] = { vim.lsp.buf.references, desc = "References of current symbol" },
            ["<leader>lR"] = { vim.lsp.buf.references, desc = "References of current symbol" },
            ["<F2>"] = { vim.lsp.buf.rename, desc = "Rename current Symbol" },
            ["<leader>lr"] = { vim.lsp.buf.rename, desc = "Rename current Symbol" },
            ["<leader>lh"] = { vim.lsp.buf.signature_help, desc = "Signature help" },
            ["gT"] = { vim.lsp.buf.type_definition, desc = "Definition of current type" },
            ["<leader>lG"] = { vim.lsp.buf.workspace_symbol, desc = "Search workspace symbols" },

            ["<leader>lf"] = {
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                desc = "Format file with LSP",
            },
        },
        v = {
            ["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" },
        },
        i = {
            ["C-h"] = { vim.lsp.buf.signature_help, desc = "Signature help" },
        },
    }

    lsp_mappings.n.gd[1] = require("telescope.builtin").lsp_definitions
    lsp_mappings.n.gI[1] = require("telescope.builtin").lsp_implementations
    lsp_mappings.n.gr[1] = require("telescope.builtin").lsp_references
    lsp_mappings.n["<leader>lR"][1] = require("telescope.builtin").lsp_references
    lsp_mappings.n.gT[1] = require("telescope.builtin").lsp_type_definitions
    lsp_mappings.n["<leader>lG"][1] = require("telescope.builtin").lsp_workspace_symbols

    if not vim.tbl_isempty(lsp_mappings.v) then
        lsp_mappings.v["<leader>l"] = { desc = (vim.g.icons_enabled and "ï " or "") .. "LSP" }
    end
    require("flitzfiete.utils").set_mappings(lsp_mappings, { buffer = bufnr })
end

return M
