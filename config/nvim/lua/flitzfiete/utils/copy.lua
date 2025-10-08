local M = {}

function M.copy_file_path()
    local filepath = vim.fn.expand('%:p') -- Get full path of current file
    if filepath == '' then
        print('No file associated with current buffer')
        return
    end
    vim.fn.setreg('+', filepath) -- Copy to system clipboard
    print('Copied file path: ' .. filepath)
end

return M
