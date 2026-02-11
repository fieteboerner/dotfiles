local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function select_git_branch(title, callback)
    local branches = vim.fn.systemlist("git branch --all --format='%(refname:short)'")

    pickers.new({}, {
        prompt_title = title,
        finder = finders.new_table(branches),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
            actions.select_default:replace(function(bufnr)
                local selection = action_state.get_selected_entry()
                actions.close(bufnr)
                callback(selection[1])
            end)
            return true
        end,
    }):find()
end

local function create_new_mr()
    select_git_branch(
        "Select target branch for new MR",
        function(target_branch)
            print("Selected branch: " .. target_branch)
            -- Here you would add the logic to create a new MR using the selected branch
            -- This could involve calling an API or running a command-line tool
            local result = vim.system({ "glab", "mr", "create", "--web", "--target-branch", target_branch },
                { text = true }):wait()
            vim.print(result)
        end
    )
end

local M = {}

function M.open_or_create_gitlab_mr()
    -- open existing
    local result = vim.system({ "glab", "mr", "view", "--web" }, { text = true }):wait()
    if result.code ~= 0 then
        -- create new one
        create_new_mr()
    end
end

return M;
