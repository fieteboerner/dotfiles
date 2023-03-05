-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Automatically install plugins on first run
if packer_bootstrap then
    require('packer').sync()
end

-- Automatically regenerate compiled loader file on save
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile>
    augroup end
]])


return require('packer').startup({
    function(use)
        -- Packer can manage itself
        use({ 'wbthomason/packer.nvim' })

        use({
            'nvim-telescope/telescope.nvim',
            tag = '0.1.0',
            -- or                          , branch = '0.1.x',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'kyazdani42/nvim-web-devicons' },
                { 'nvim-telescope/telescope-fzf-native.nvim',    run = 'make' },
                { 'nvim-telescope/telescope-live-grep-args.nvim' },
            },
            config = function()
                require('flitzfiete.plugins.telescope')
                require('telescope').setup({
                    defaults = {
                        color_devicons = true
                    }
                })
            end
        })

        use({
            'folke/tokyonight.nvim',
            config = function()
                vim.cmd('colorscheme tokyonight-moon')
            end
        })
        use({
            'jessarcher/onedark.nvim',
            config = function()
                -- vim.cmd('colorscheme onedark')

                -- Hide the characters in FloatBorder
                vim.api.nvim_set_hl(0, 'FloatBorder', {
                    fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
                    bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
                })

                -- Make the StatusLineNonText background the same as StatusLine
                vim.api.nvim_set_hl(0, 'StatusLineNonText', {
                    fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
                    bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
                })

                -- Hide the characters in CursorLineBg
                vim.api.nvim_set_hl(0, 'CursorLineBg', {
                    fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
                    bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
                })

                vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
                vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
            end,
        })

        use({
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'nvim-treesitter/playground',
                'nvim-treesitter/nvim-treesitter-textobjects',
                'JoosepAlviste/nvim-ts-context-commentstring',
            },
            run = ':TSUpdate',
            config = function()
                require('flitzfiete.plugins.treesitter')
            end
        })

        use({
            'mbbill/undotree',
            config = function()
                require('flitzfiete.plugins.undotree')
            end
        })

        use({
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                -- { 'hrsh7th/cmp-nvim-lua' },

                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },
            },
            config = function()
                require('flitzfiete.lsp.lsp')
                require('flitzfiete.plugins.cmp')
            end
        })

        use({
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
                require('flitzfiete.plugins.null-ls')
            end
        })

        use({ 'tpope/vim-commentary' })
        use({ 'tpope/vim-vinegar' })
        use({ 'tpope/vim-surround' })
        use({ 'tpope/vim-sleuth' }) -- autodetection of settings from .editorconfig
        use({ 'tpope/vim-eunuch' }) -- adds :Rename and :WriteSudo
        use({ 'tpope/vim-repeat' }) -- allow plugins to enable repeating commands (eg. cs"' for vim-surround)
        use('tpope/vim-unimpaired') -- Adds [b and other handy mappings
        use({
            'christoomey/vim-tmux-navigator',
            config = function()
                vim.g.tmux_navigator_no_mappings = 1
                vim.keymap.set('n', '<C-S-h>', ':<C-U>TmuxNavigateLeft<CR>')
                vim.keymap.set('n', '<C-S-j>', ':<C-U>TmuxNavigateDown<CR>')
                vim.keymap.set('n', '<C-S-k>', ':<C-U>TmuxNavigateUp<CR>')
                vim.keymap.set('n', '<C-S-l>', ':<C-U>TmuxNavigateRight<CR>')
            end
        })

        use({
            'AndrewRadev/splitjoin.vim',
            config = function()
                vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
                vim.g.splitjoin_trailing_comma = 1
                vim.g.splitjoin_php_method_chain_full = 1
            end,
        })


        -- git
        use({
            'lewis6991/gitsigns.nvim',
            config = function()
                require('flitzfiete.plugins.gitsigns')
            end
        })
        use({
            'APZelos/blamer.nvim',
            config = function()
                vim.g.blamer_enabled = 1
            end
        })
        use({
            'kdheepak/lazygit.nvim'
        })

        use('farmergreg/vim-lastplace') -- jump to the last location when opening a file

        -- allows to edit html attributes with ax & ix
        use({
            'whatyouhide/vim-textobj-xmlattr',
            requires = 'kana/vim-textobj-user',
        })

        -- paste with correct indentation
        use({ 'sickill/vim-pasta' })

        use({
            'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup()
            end,
        })


        use({
            'karb94/neoscroll.nvim',
            config = function()
                require('flitzfiete.plugins.neoscroll')
            end,
        })

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        }
        require('flitzfiete.plugins.lualine')

        use({
            'airblade/vim-rooter',
            -- setup = function()
            --     -- instead of running every time by opening a file, it runs only on vim start
            --     vim.g.rooter_manual_only = 1
            -- end,
            -- config = function()
            --     vim.cmd('Rooter')
            -- end
        })

        use({
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly', -- optional, updated every week.
            config = function()
                vim.g.loaded_netrw = 1
                vim.g.loaded_netrwPlugin = 1
                require("nvim-tree").setup({
                    renderer = {
                        group_empty = true,
                    },
                    actions = {
                        open_file = {
                            quit_on_open = true,
                        }
                    }
                })

                vim.keymap.set('n', '<leader>b', ':NvimTreeFindFileToggle<CR>')
            end
        })


        use({
            'RRethy/vim-illuminate',
            config = function()
                require('flitzfiete.plugins.illuminate')
            end
        })

        use({
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('flitzfiete.plugins.indent-blankline')
            end,
        })

        use({
            'voldikss/vim-floaterm',
            config = function()
                require('flitzfiete.plugins.floaterm')
            end,
        })
    end,
    config = {
        display = {
            open_fn = require('packer.util').float
        }
    }
})
