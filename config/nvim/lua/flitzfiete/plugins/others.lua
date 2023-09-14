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
    filetype_exclude = {
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
    buftype_exclude = {
        "terminal",
    },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
}

M.gitsigns = {
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
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

M.setupLuasnip = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    local ls = require("luasnip")
    ls.config.set_config({
        history = true,
        udateevents = "TextChanged,TextChangedI",
    })

    ls.add_snippets("php", {
        ls.parser.parse_snippet("class", "class $1\n{\n    $0\n}"),
        ls.parser.parse_snippet("pubf", "public function $1($2): $3\n{\n    $0\n}"),
        ls.parser.parse_snippet("prif", "private function $1($2): $3\n{\n    $0\n}"),
        ls.parser.parse_snippet("prof", "protected function $1($2): $3\n{\n    $0\n}"),
        ls.parser.parse_snippet("testt", "public function test_$1()\n{\n    $0\n}"),
        ls.parser.parse_snippet("testa", "/** @test */\npublic function $1()\n{\n    $0\n}"),
    })

    ls.add_snippets("typescript", {
        ls.parser.parse_snippet("imp", "import $1 from '$0'"),
        ls.parser.parse_snippet("imd", "import {$1} from '$0'"),
    })

    ls.add_snippets("vue", {
        ls.parser.parse_snippet("defineProps", "defineProps<{\n  $0\n}>()"),
        ls.parser.parse_snippet("props", "const props = defineProps<{\n  $0\n}>()"),
        ls.parser.parse_snippet("script", '<script lang="ts"${1: setup}>\n  $0\n</script>'),
        ls.parser.parse_snippet("style", '<style${1: lang="scss"}${2: scoped}>\n  $0\n</style>'),
    })
end

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
