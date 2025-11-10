-- Bufferline 
-- Load the existing powerline_dark theme
local custom_powerline_dark = require('lualine.themes.powerline_dark')

-- Define a specific blue color you want to use
local colors = {
  black        = '#202020',
  neon         = '#DFFF00',
  white        = '#FFFFFF',
  green        = '#00D700',
  purple       = '#5F005F',
  blue         = '#00DFFF',
  darkblue     = '#00005F',
  navyblue     = '#000080',
  brightgreen  = '#9CFFD3',
  gray         = '#444444',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
  orange       = '#FFAF00',
  red          = '#5F0000',
  brightorange = '#C08A20',
  brightred    = '#AF0000',
  cyan         = '#00DFFF',
}

-- Example: Change the background of section 'a' in normal mode to this blue
custom_powerline_dark.normal.a.bg = colors.brightred
custom_powerline_dark.normal.a.fg = colors.white

custom_powerline_dark.normal.b.bg = colors.cyan
custom_powerline_dark.normal.b.fg = colors.darkblue

custom_powerline_dark.normal.c.bg = colors.navyblue
custom_powerline_dark.normal.c.fg = colors.white

custom_powerline_dark.inactive.a.bg = colors.navyblue
custom_powerline_dark.inactive.a.fg = colors.white

custom_powerline_dark.inactive.b.bg = colors.cyan
custom_powerline_dark.inactive.b.fg = colors.darkblue

custom_powerline_dark.inactive.c.bg = colors.navyblue
custom_powerline_dark.inactive.c.fg = colors.white

require("lualine").setup{
    options = {
        icons_enabled = true,
        theme = custom_powerline_dark,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {'location'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      }
    },
  extensions = {
    'nerdtree' -- Enable the NERDTree extension
  }
}

