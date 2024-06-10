local M = {}

M.setup = function()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup()
    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    -- color the icons
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#4285f4" })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "󰟃", texthl = "DapBreakpointCodition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapStopped", { text = "󰁕", texthl = "DapStopped", linehl = "", numhl = "" })

    -- configure engines
    dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            args = { vim.fn.stdpath("data") .. "/debuggers/js-debug/src/dapDebugServer.js", "${port}" },
        },
    }
    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/debuggers/vscode-node-debug2/out/src/nodeDebug.js" },
    }
    local js_based_languages = { "typescript", "javascript", "typescriptreact" }
    for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                name = "Launch",
                type = "node2",
                request = "launch",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                console = "integratedTerminal",
            },
            {
                -- For this to work you need to make sure the node process is started with the `--inspect` flag.
                name = "Attach to process",
                type = "node2",
                request = "attach",
                processId = require("dap.utils").pick_process,
            },
        }
    end
    dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/debuggers/vscode-php-debug/out/phpDebug.js" },
    }
    dap.configurations.php = {
        {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003,
        },
    }
end

M.setup_go = function()
    require("dap-go").setup({
        dap_configurations = {
            {
                type = "go",
                name = "Debug Project .",
                request = "launch",
                program = ".",
                buildFlags = "-C ${fileDirname}",
            },
        },
    })
end

return M
