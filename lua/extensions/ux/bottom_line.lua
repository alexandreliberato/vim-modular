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
  cyan         = '#00DFFF'
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

-- backend‑oriented lualine components
local function project_root()
  local ok, radix = pcall(require, 'radix')
  if not ok then return '' end
  local root = radix.get_root_dir(vim.fn.getcwd() or '')

  if not root or root == '' then return '' end
  return ' ' .. vim.fn.fnamemodify(root, ':t')
end

local function python_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv and venv ~= '' then
    return ' ' .. vim.fn.fnamemodify(venv, ':t')
  end
  return ''
end

local function coc_status()
  if vim.fn.exists('*coc#status') == 1 then
    return vim.fn['coc#status']()
  end
  return ''
end

local function session_name()
  local ok, lib = pcall(require, 'auto-session.lib')
  if not ok then return '' end
  local name = lib.current_session_name(true)
  return name or ''
end

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
        globalstatus = true,
    },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
              { 'branch', icon = '' },
              'diff',
              {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                sections = { 'error', 'warn', 'hint', 'info' },
                symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
                colored = true,
                update_in_insert = false,
              },
            },
        lualine_c = {
          {
            'filename',
            path = 1, -- 1 displays the relative path from cwd (project root)
            file_status = true, -- displays file status (readonly, modified, etc.)
          },
        },
        --lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = {
          'location',
          { coc_status, cond = function() return vim.fn.exists('*coc#status') == 1 end },
          { python_venv, cond = function() return vim.bo.filetype == 'python' end },
          'encoding',
          'fileformat',
          'filetype',
          { session_name },
        },
        --lualine_y = {'progress'},
    lualine_y = {
      { session_name, cond = function() return pcall(require, 'auto-session.lib') end },
      'progress',
    },
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {'location'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
  extensions = {
    'nerdtree' -- Enable the NERDTree extension
  }
}


