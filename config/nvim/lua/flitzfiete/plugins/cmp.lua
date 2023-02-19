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
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping {
            i = cmp.mapping.complete(),
        },
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        }
    },
})
