local M = {}

function M.copy_relative_file_path()
    local filepath = vim.fn.expand('%:a') -- Get relative path of current file
    if filepath == '' then
        print('No file associated with current buffer')
        return
    end
    vim.fn.setreg('+', filepath) -- Copy to system clipboard
    print('Copied file path: ' .. filepath)
end

function M.copy_absolute_file_path()
    local filepath = vim.fn.expand('%:p') -- Get absolute path of current file
    if filepath == '' then
        print('No file associated with current buffer')
        return
    end
    vim.fn.setreg('+', filepath) -- Copy to system clipboard
    print('Copied file path: ' .. filepath)
end

function M.copy_branch_name()
    local result = vim.system({ "git", "branch", "--show-current" }, { text = true }):wait()
    local branch_name = result.stdout:gsub("%s+", "")
    if branch_name == '' then
        print('Not in a git repository')
        return
    end
    vim.fn.setreg('+', branch_name) -- Copy to system clipboard
    print('Copied branch name: ' .. branch_name)
end

return M
