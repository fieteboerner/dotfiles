local lsp = require ("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    -- 'eslint',
    'sumneko_lua',
    'yamlls',
    'jonsls',
    'html',
    'cssls',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            }
        },
    }
})

lsp.configure('yamlls', {
    settings = {
        yaml = {
            schemas = {
                kubernetes = "*.yaml"
            }
        }
    }
})

lsp.configure('jsonls', {
    settings = {
        json = {
            schemas = {
                {
                    description = "TypeScript compiler configuration file",
                    fileMatch = {
                        "tsconfig.json",
                        "tsconfig.*.json",
                    },
                    url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                    description = "Lerna config",
                    fileMatch = { "lerna.json" },
                    url = "https://json.schemastore.org/lerna.json",
                },
                {
                    description = "Babel configuration",
                    fileMatch = {
                        ".babelrc.json",
                        ".babelrc",
                        "babel.config.json",
                    },
                    url = "https://json.schemastore.org/babelrc.json",
                },
                {
                    description = "ESLint config",
                    fileMatch = {
                        ".eslintrc.json",
                        ".eslintrc",
                    },
                    url = "https://json.schemastore.org/eslintrc.json",
                },
                {
                    description = "Bucklescript config",
                    fileMatch = { "bsconfig.json" },
                    url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
                },
                {
                    description = "Prettier config",
                    fileMatch = {
                        ".prettierrc",
                        ".prettierrc.json",
                        "prettier.config.json",
                    },
                    url = "https://json.schemastore.org/prettierrc",
                },
                {
                    description = "Vercel Now config",
                    fileMatch = { "now.json" },
                    url = "https://json.schemastore.org/now",
                },
                {
                    description = "Stylelint config",
                    fileMatch = {
                        ".stylelintrc",
                        ".stylelintrc.json",
                        "stylelint.config.json",
                    },
                    url = "https://json.schemastore.org/stylelintrc",
                },
                {
                    description = "A JSON schema for the ASP.NET LaunchSettings.json files",
                    fileMatch = { "launchsettings.json" },
                    url = "https://json.schemastore.org/launchsettings.json",
                },
                {
                    description = "Schema for CMake Presets",
                    fileMatch = {
                        "CMakePresets.json",
                        "CMakeUserPresets.json",
                    },
                    url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
                },
                {
                    description = "Configuration file as an alternative for configuring your repository in the settings page.",
                    fileMatch = {
                        ".codeclimate.json",
                    },
                    url = "https://json.schemastore.org/codeclimate.json",
                },
                {
                    description = "LLVM compilation database",
                    fileMatch = {
                        "compile_commands.json",
                    },
                    url = "https://json.schemastore.org/compile-commands.json",
                },
                {
                    description = "Config file for Command Task Runner",
                    fileMatch = {
                        "commands.json",
                    },
                    url = "https://json.schemastore.org/commands.json",
                },
                {
                    description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
                    fileMatch = {
                        "*.cf.json",
                        "cloudformation.json",
                    },
                    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
                },
                {
                    description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
                    fileMatch = {
                        "serverless.template",
                        "*.sam.json",
                        "sam.json",
                    },
                    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
                },
                {
                    description = "Json schema for properties json file for a GitHub Workflow template",
                    fileMatch = {
                        ".github/workflow-templates/**.properties.json",
                    },
                    url = "https://json.schemastore.org/github-workflow-template-properties.json",
                },
                {
                    description = "golangci-lint configuration file",
                    fileMatch = {
                        ".golangci.toml",
                        ".golangci.json",
                    },
                    url = "https://json.schemastore.org/golangci-lint.json",
                },
                {
                    description = "JSON schema for the JSON Feed format",
                    fileMatch = {
                        "feed.json",
                    },
                    url = "https://json.schemastore.org/feed.json",
                    versions = {
                        ["1"] = "https://json.schemastore.org/feed-1.json",
                        ["1.1"] = "https://json.schemastore.org/feed.json",
                    },
                },
                {
                    description = "Packer template JSON configuration",
                    fileMatch = {
                        "packer.json",
                    },
                    url = "https://json.schemastore.org/packer.json",
                },
                {
                    description = "NPM configuration file",
                    fileMatch = {
                        "package.json",
                    },
                    url = "https://json.schemastore.org/package.json",
                },
                {
                    description = "JSON schema for Visual Studio component configuration files",
                    fileMatch = {
                        "*.vsconfig",
                    },
                    url = "https://json.schemastore.org/vsconfig.json",
                },
                {
                    description = "Resume json",
                    fileMatch = { "resume.json" },
                    url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
                },
            }
        }
    }
})

-- lsp.configure('eslint', {
--     code_actions = {
--         enable = true,
--         apply_on_save = {
--             enable = true,
--         },
--     },
--     diagnostics = {
--         enable = true,
--         run_on = 'type',
--     },
-- })

-- lsp.configure('tsserver', {
--     on_attach = function(client)
--         client.server_capabilities.document_formatting = false
--     end
-- })


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = '',
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

-- configure autocompletion dropdown
local kind_icons = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = '',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

local source_labels = {
    buffer = "Buffer",
    nvim_lsp = "LSP",
    luasnip = "LuaSnip",
    nvim_lua = "Lua",
    latex_symbols = "LaTeX",
}

require('cmp').setup({
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = source_labels[entry.source.name]

            return vim_item
        end
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        }
    }
})
