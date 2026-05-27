local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

local function get_php_param_info(paramNode)
    local info = {
        type = "",
        name = "",
    }
    for paramPart in paramNode:iter_children() do
        if paramPart:type() == "variable_name" then
            info.name = vim.treesitter.get_node_text(paramPart, 0)
        end
        if paramPart:type() == "named_type" then
            info.type = vim.treesitter.get_node_text(paramPart, 0)
        end
    end
    return info
end

local function build_comment(paramInfos, returnType)
    -- Generate the docblock
    local docblock = { "/**" }

    -- Add @param lines
    for _, param in ipairs(paramInfos) do
        table.insert(docblock, string.format(" * @param %s %s", param.type, param.name))
    end

    -- Add @return line
    if returnType then
        table.insert(docblock, string.format(" * @return %s", returnType))
    end

    table.insert(docblock, " */")

    return docblock
end

local function write_comment(node, comment)
    local bufnr = vim.api.nvim_get_current_buf()
    local row, _ = node:start()
    vim.api.nvim_buf_set_lines(bufnr, row, row, false, comment)
end

-- Function to generate a PHP docblock
local function generate_php_docblock()
    if not vim.bo.filetype == "php" then
        return
    end
    local node = vim.treesitter.get_node()
    if not node then
        return nil
    end

    -- Traverse up the tree to find a function/method declaration node
    while node do
        if
            node:type() == "method_declaration"
            or node:type() == "function_definition"
            or node:type() == "class_declaration"
        then
            break
        end
        node = node:parent()
    end

    if not node then
        -- print("No function or method found at cursor!")
        return
    end

    if node:type() == "class_declaration" then
        write_comment(node, { "/** */" })
        return
    end

    -- if comment already exists
    local prevNode = ts_utils.get_previous_node(node)
    if prevNode and prevNode:type() == "comment" then
        return
    end

    -- Extract parameters and return type
    local params = {}
    local returnType = "void"

    for child in node:iter_children() do
        if child:type() == "formal_parameters" then
            -- Iterate over parameter nodes
            for param in child:iter_children() do
                if param:type() == "simple_parameter" then
                    table.insert(params, get_php_param_info(param))
                end
            end
        end
        if child:type() == "named_type" or child:type() == "primitive_type" then
            returnType = vim.treesitter.get_node_text(child, 0)
        end
    end

    local docblock = build_comment(params, returnType)
    write_comment(node, docblock)
end

M.generate_php_docblock = generate_php_docblock

return M
