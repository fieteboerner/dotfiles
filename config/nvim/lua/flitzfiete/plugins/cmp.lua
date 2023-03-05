local lsp = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')

-- configure autocompletion dropdown
local kind_icons = {
    Text = ' ',
    Method = ' ',
    Function = ' ',
    Constructor = ' ',
    Field = ' ',
    Variable = ' ',
    Class = ' ',
    Interface = ' ',
    Module = ' ',
    Property = ' ',
    Unit = '',
    Value = ' ',
    Enum = ' ',
    Keyword = ' ',
    Snippet = ' ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    EnumMember = ' ',
    Constant = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
}

local source_labels = {
    buffer = "Buffer",
    nvim_lsp = "LSP",
    luasnip = "LuaSnip",
    nvim_lua = "Lua",
    latex_symbols = "LaTeX",
}

vim.o.completeopt = 'menuone,longest,preview'

cmp.setup({
    preselect = cmp.PreselectMode.None,
    experimental = {
        ghost_text = true,
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = source_labels[entry.source.name]

            return vim_item
        end
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<M-a>"] = cmp.mapping {
            i = cmp.mapping.complete(),
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable( -1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    window = {
        completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
})
