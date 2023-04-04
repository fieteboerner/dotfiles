local global_commands = {
    system_open = function(state) require("flitzfiete.utils").system_open(state.tree:get_node():get_id()) end,
    parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
        else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
    end,
    child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
                state.commands.toggle_node(state)
            else -- if expanded and has children, seleect the next child
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
        else -- if not a directory just open it
            state.commands.open(state)
        end
    end,
}

local get_icon = require("flitzfiete.utils").get_icon

require('neo-tree').setup({
    close_if_last_window = true,
    source_selector = {
        winbar = true,
        content_layout = "center",
        tab_labels = {
            filesystem = get_icon "FolderClosed" .. " File",
            buffers = get_icon "DefaultFile" .. " Bufs",
            git_status = get_icon "Git" .. " Git",
            diagnostics = get_icon "Diagnostic" .. " Diagnostic",
        },
    },
    default_component_configs = {
        indent = { padding = 0 },
        icon = {
            folder_closed = get_icon "FolderClosed",
            folder_open = get_icon "FolderOpen",
            folder_empty = get_icon "FolderEmpty",
            default = get_icon "DefaultFile",
        },
        modified = { symbol = get_icon "FileModified" },
        git_status = {
            symbols = {
                added = get_icon "GitAdd",
                deleted = get_icon "GitDelete",
                modified = get_icon "GitChange",
                renamed = get_icon "GitRenamed",
                untracked = get_icon "GitUntracked",
                ignored = get_icon "GitIgnored",
                unstaged = get_icon "GitUnstaged",
                staged = get_icon "GitStaged",
                conflict = get_icon "GitConflict",
            },
        },
    },
    window = {
        width = 30,
        mappings = {
            ["<space>"] = false, -- disable space until we figure out which-key disabling
            ["[b"] = "prev_source",
            ["]b"] = "next_source",
            o = "child_or_open",
            O = "system_open",
            h = "parent_or_close",
            l = "child_or_open",
        },
    },
    filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        commands = global_commands,
        filtered_items = {
            hide_by_name = {
                ".git"
            },
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
    buffers = { commands = global_commands },
    git_status = { commands = global_commands },
    event_handlers = {
        { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
    },
})
