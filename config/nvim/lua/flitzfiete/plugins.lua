local plugins = {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        init = function()
            vim.cmd("colorscheme tokyonight-moon")
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        init = function()
            require("flitzfiete.utils").lazy_load("nvim-colorizer.lua")
        end,
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
        config = function(_, opts)
            require("colorizer").setup(opts)

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },
    {
        "windwp/nvim-ts-autotag", -- auto close and rename html tags
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            per_filetype = {
                ["php"] = {
                    enable_close = false, -- disable to not break the repeat in php files (->foo -foo)
                },
            },
        },
        config = function(_, opts)
            require("nvim-ts-autotag").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        init = function()
            require("flitzfiete.utils").lazy_load("nvim-treesitter")
        end,
        opts = require("flitzfiete.plugins.treesitter"),
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }
        end,
    },

    { "mbbill/undotree", event = "VeryLazy" },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        cmd = "Telescope",
        opts = function()
            return require("flitzfiete.plugins.telescope")
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            -- load extensions
            for _, ext in ipairs(opts.ensure_extentions) do
                -- telescope.load_extension(ext)
            end
        end,
    },

    {
        "github/copilot.vim",
        event = "InsertEnter",
        cmd = { "Copilot" },
        config = function()
            vim.keymap.set("i", "<C-e>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
            vim.g.copilot_no_tab_map = true
        end,
    },

    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        lazy = false,
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
                opts = function()
                    return require("flitzfiete.plugins.mason")
                end,
                config = function(_, opts)
                    require("mason").setup(opts)
                end,
            },
            -- Autocompletion
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    {
                        "windwp/nvim-autopairs",
                        opts = {
                            fast_wrap = {},
                            disable_filetype = { "TelescopePrompt", "vim" },
                        },
                        config = function(_, opts)
                            require("nvim-autopairs").setup(opts)

                            -- setup cmp for autopairs
                            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                        end,
                    },
                    {
                        "zbirenbaum/copilot-cmp",
                        config = function()
                            require("copilot_cmp").setup()
                        end,
                    },
                },
            },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                version = "v2.*",
                build = "make install_jsregexp",
                config = function()
                    require("flitzfiete.plugins.luasnip").setup()
                end,
            },
        },
        config = function(_, opts)
            require("cmp").setup(require("flitzfiete.plugins.cmp"))
            require("flitzfiete.lsp.lsp").setup()
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = { hint_enable = false },
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require("flitzfiete.plugins.null-ls")
        end,
    },
    -- test
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "olimorris/neotest-phpunit",
        },
        opts = function()
            return require("flitzfiete.plugins.neotest")
        end,
        config = function(_, opts)
            require("neotest").setup(opts)
            -- require("neotest.logging"):set_level(vim.log.levels.DEBUG)
        end,
    },

    -- dap / debugging
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            { "mfussenegger/nvim-dap" },
            { "nvim-neotest/nvim-nio" },
            { "theHamsta/nvim-dap-virtual-text" },
        },
        event = "VeryLazy",
        config = function()
            require("flitzfiete.plugins.dap").setup()
        end,
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        config = function()
            require("flitzfiete.plugins.dap").setup_go()
        end,
    },

    { "tpope/vim-commentary", event = "VeryLazy" },
    { "tpope/vim-vinegar", event = "VeryLazy" },
    { "tpope/vim-sleuth", event = "VeryLazy" }, -- autoload .editorconfig settings
    { "tpope/vim-repeat", event = "VeryLazy" }, -- allow plugins to enable repeating commands (eg. cs"' for vim-surround)
    { "farmergreg/vim-lastplace", lazy = false }, -- jump to the last location when opening a file
    { "sickill/vim-pasta", event = "VeryLazy" }, -- jump to the last location when opening a filedF
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
    },

    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
        init = function()
            vim.g.tmux_navigator_no_mappings = 1
        end,
        config = function()
            vim.keymap.set("n", "<C-S-h>", ":<C-U>TmuxNavigateLeft<CR>")
            vim.keymap.set("n", "<C-S-j>", ":<C-U>TmuxNavigateDown<CR>")
            vim.keymap.set("n", "<C-S-k>", ":<C-U>TmuxNavigateUp<CR>")
            vim.keymap.set("n", "<C-S-l>", ":<C-U>TmuxNavigateRight<CR>")
        end,
    },

    {
        "AndrewRadev/splitjoin.vim",
        event = "VeryLazy",
        init = function()
            vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_php_method_chain_full = 1
        end,
    },

    -- git
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                        vim.schedule(function()
                            require("lazy").load({ plugins = { "gitsigns.nvim" } })
                        end)
                    end
                end,
            })
        end,
        opts = require("flitzfiete.plugins.others").gitsigns,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    {
        "APZelos/blamer.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.blamer_enabled = 1
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
    },

    -- allows to edit html attributes with ax & ix
    {
        "whatyouhide/vim-textobj-xmlattr",
        event = "VeryLazy",
        dependencies = { "kana/vim-textobj-user" },
    },

    {
        "windwp/nvim-autopairs",
        event = "BufEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            return require("flitzfiete.plugins.neoscroll")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = function()
            return require("flitzfiete.plugins.lualine")
        end,
    },

    {
        "airblade/vim-rooter",
        lazy = false,
        init = function()
            vim.g.rooter_patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" }
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        cmd = { "Neotree" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = function()
            return require("flitzfiete.plugins.neo-tree")
        end,
    },
    {
        "stevearc/oil.nvim",
        opts = require("flitzfiete.plugins.others").oil,
        lazy = false,
    },

    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        opts = require("flitzfiete.plugins.others").illuminate,
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = require("flitzfiete.plugins.others").indentBlankline,
        config = function(_, opts)
            require("ibl").setup(opts)
        end,
    },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = function()
            return require("flitzfiete.plugins.others").dressing
        end,
    },
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            local notify = require("notify")
            notify.setup({
                stages = "fade",
                top_down = false,
            })
            local banned_messages = { "No information available" }
            vim.notify = function(msg, ...)
                for _, banned in ipairs(banned_messages) do
                    if msg == banned then
                        return
                    end
                end
                notify(msg, ...)
            end
        end,
    },

    {
        "folke/which-key.nvim",
        -- keys = { "<leader>", '"', "'", "`", "c", "v" },
        lazy = false,
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                icons = { mappings = false },
            })
        end,
    },

    {
        "voldikss/vim-floaterm",
        cmd = { "FloatermToggle", "FloatermShow" },
        init = require("flitzfiete.plugins.floaterm").init,
    },

    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Spectre" },
        keys = { "<leader>fs", "<leader>fsw" },
    },

    {
        "olexsmir/gopher.nvim",
        ft = "go",
        cmd = { "GoIfErr" },
        config = function(_, opts)
            require("gopher").setup(opts)
        end,
        build = function()
            vim.cmd([[silent! GoInstallDeps]])
        end,
    },
}

require("lazy").setup(plugins, require("flitzfiete.plugins.lazy_nvim"))
