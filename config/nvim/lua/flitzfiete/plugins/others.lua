local get_icon = require("flitzfiete.utils").get_icon

local M = {}

M.dressing = {
    input = {
        default_prompt = get_icon("Prompt"),
        border = "rounded",
        win_options = { winhighlight = "FloatBorder:Normal,NormalNC:Normal" },
    },
    select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
    },
}

M.illuminate = {
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
    filetypes_denylist = {
        "oil",
        "NvimTree",
        "TelescopePrompt",
    },
}

M.indentBlankline = {
    exclude = {
        filetypes = {
            "help",
            "terminal",
            "dashboard",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "nvcheatsheet",
            "mason",
        },
        buftypes = {
            "terminal",
        }
    },
}

M.gitsigns = {
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
    },
    preview_config = {
        border = "rounded",
    },
}

M.oil = {
    use_default_keymaps = false,
    keymaps = {
        ["<C-c>"] = "actions.close",
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
        ["g?"] = "actions.show_help",
    },

    view_options = { show_hidden = true },
}

M.setupOneDark = function()
    -- Hide the characters in FloatBorder
    vim.api.nvim_set_hl(0, "FloatBorder", {
        fg = vim.api.nvim_get_hl_by_name("NormalFloat", true).background,
        bg = vim.api.nvim_get_hl_by_name("NormalFloat", true).background,
    })

    -- Make the StatusLineNonText background the same as StatusLine
    vim.api.nvim_set_hl(0, "StatusLineNonText", {
        fg = vim.api.nvim_get_hl_by_name("NonText", true).foreground,
        bg = vim.api.nvim_get_hl_by_name("StatusLine", true).background,
    })

    -- Hide the characters in CursorLineBg
    vim.api.nvim_set_hl(0, "CursorLineBg", {
        fg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
        bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
    })

    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#30323E" })
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2F313C" })
end

return M
