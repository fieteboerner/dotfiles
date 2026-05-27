local actions = require("telescope.actions")
return {
    extensions = {
        fzf = {
            override_generic_sorter = false,
            override_file_sorter = false,
        },
    },
    defaults = {
        color_devicons = true,
        prompt_prefix = "  ",
        selection_caret = " ",
        entry_prefix = "  ",
        file_ignore_patterns = { ".git/", "node_modules/", "vendor/" },
        shorten_path = true,
        path_display = { shorten = 5 },
        previewer = false,
        layout_config = {
            prompt_position = "top",
        },
        sorting_strategy = "ascending",
        mappings = {
            n = {
                ["<esc"] = actions.close,
                ["<Space>"] = actions.select_default,
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
                ["<C-Down>"] = actions.cycle_history_next,
                ["<C-Up>"] = actions.cycle_history_prev,
            },
            i = {
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
                ["<C-Down>"] = actions.cycle_history_next,
                ["<C-Up>"] = actions.cycle_history_prev,
            },
        },
        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            -- "--ignore-case",
            -- "--sort=path",
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            -- cache_picker = true,
        },
        lsp_references = {
            theme = "dropdown",
        },
        lsp_definitions = {
            -- remove modules to allow to go to definition via lsp
            file_ignore_patterns = { ".git/" },
        },
        oldfiles = {
            hidden = false,
            cwd_only = true,
            no_ignore = true,
            -- on_complete = {
            --     function()
            --         vim.cmd("stopinsert")
            --     end,
            -- },
        },
        grep_string = {
            previewer = true,
        },
        live_grep = {
            previewer = true,
        },
    },

    -- not provided by the plugin
    ensure_extentions = { "fzf", "live_grep_args" },
}
