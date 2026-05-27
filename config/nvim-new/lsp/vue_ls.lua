return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = {
        "package.json",
        "vue.config.js",
        "vite.config.js",
        "vite.config.ts",
        "nuxt.config.js",
        "nuxt.config.ts",
        ".git",
    },
    on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
            local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })
            if #ts_clients == 0 then
                vim.notify("Could not find `ts_ls` lsp client, `vue_ls` would not work without it.", vim.log.levels.ERROR)
                return
            end

            local ts_client = ts_clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)

            ts_client:exec_cmd({
                title = "vue_request_forward",
                command = "typescript.tsserverRequest",
                arguments = { command, payload },
            }, { bufnr = context.bufnr }, function(_, response)
                client:notify("tsserver/response", { { id, response and response.body } })
            end)
        end
    end,
}
