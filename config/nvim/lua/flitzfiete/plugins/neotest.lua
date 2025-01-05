return {
    adapters = {
        require("neotest-vitest")({
            -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
            filter_dir = function(name, rel_path, root)
                return name ~= "node_modules"
            end,
        }),
        require("neotest-phpunit")({
            root_files = { "phpunit.xml", "composer.json" },
            phpunit_cmd = function()
                return os.getenv("HOME") .. "/.dotfiles/config/nvim/scripts/docker-phpunit.sh"
            end,
            filter_dirs = { "vendor" },
            env = function()
                local cwd = vim.fn.getcwd()
                if cwd == "/home/fiete/code/fermenthero-api" then
                    return {
                        CONTAINER = "fermenthero-api-app-1",
                    }
                end
                if cwd == "/home/fiete/code/adzlocal/apps/system" then
                    return {
                        CONTAINER = "system-app-php-1",
                    }
                end
                return {}
            end,
        }),
    },
}
