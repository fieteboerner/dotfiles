local get_icon = require("flitzfiete.utils").get_icon

local options = {
    ui = {
        icons = {
            package_pending = get_icon("MasonInstalling"),
            package_installed = get_icon("MasonInstalled"),
            package_uninstall = get_icon("MasonUninstalled"),
        },

        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        },
    },

    max_concurrent_installers = 10,
}

return options
