return {
    defaults = {
        color_devicons = true,
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        file_ignore_patterns = { ".git/", "node_modules/", "vendor/" },
        shorten_path = true,
        path_display = { "smart" },
        layout_config = {
            prompt_position = "top",
        },
        sorting_strategy = "ascending",
        mappings = {
            n = {
                ["<esc"] = require("telescope.actions").close,
                ["<Space>"] = require("telescope.actions").select_default,
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
