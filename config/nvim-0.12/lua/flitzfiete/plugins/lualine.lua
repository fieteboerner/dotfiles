local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    purple = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }

  local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
          return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
          }
      end
  end

  require('lualine').setup {
      options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '',
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
              statusline = {},
              winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
          }
      },
      sections = {
          lualine_a = { 'mode' },
          lualine_b = {
              {
                  "branch",
                  "b:gitsigns_head",
                  icon = "",
                  color = { gui = "bold", }
              },
          },
          lualine_c = {
              {
                  "diff",
                  source = diff_source,
                  symbols = {
                      added = " ",
                      modified = " ",
                      removed = " ",
                  },
                  padding = { left = 1, right = 1 },
                  diff_color = {
                      added = { fg = colors.green },
                      modified = { fg = colors.yellow },
                      removed = { fg = colors.red },
                  },
                  cond = nil,
              },
              {
                  'filename',
                  file_status = true, -- displays file status (readonly, modified)
                  path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
              },
          },
          lualine_x = {
              { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
              {
                  function()
                      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
                      return " " .. shiftwidth
                  end
              },
              'encoding',
              'filetype'
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
      },
      inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
  }
