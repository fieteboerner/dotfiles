local actions = require("telescope.actions")
return {
    defaults = {
        color_devicons = true,
        prompt_prefix = "  ",
        selection_caret = " ",
        entry_prefix = "  ",
        file_ignore_patterns = { ".git/", "node_modules/", "vendor/" },
        shorten_path = true,
        path_display = { "truncate" },
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
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            previewer = false,
            -- cache_picker = true,
        },
        lsp_references = {
            theme = "dropdown",
            previewer = false,
        },
        oldfiles = {
            cwd_only = true,
            on_complete = {
                function()
                    vim.cmd("stopinsert")
                end,
            },
        },
    },

    -- not provided by the plugin
    ensure_extentions = { "fzf", "live_grep_args" },
}
