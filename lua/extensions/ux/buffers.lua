-- [[ Configure buffers using Lua Line ]] 

-- Bufferline plugin configuration
vim.opt.termguicolors = true

-- Bufferline 
-- require("bufferline").setup{
--     options = {
--         --style_preset = bufferline.style_preset.minimal,
--         diagnostics = "coc",
--         diagnostics_indicator = function(count, level, diagnostics_dict, context)
--           local icon = level:match("error") and " " or " "
--           return " " .. icon .. count
--         end,
--         offsets = {
--                         {
--                             filetype = "nerdtree",
--                             text = "File Explorer",
--                             text_align = "center",
-- --                            highlight = "Directory",
--                             separator = true
--                         }
--                     },
--         },
-- }

local function getLastFromPath(path)
    local last = path:match("([^/]+)$")
    return last
end

local rootDirectory = require("radix").get_root_dir(vim.fn.getcwd())
local sidebarText = '| File Explorer | ' .. '>> ' ..string.upper(getLastFromPath(rootDirectory)) .. ' <<'

vim.g.barbar_auto_setup = false -- disable auto-setup
require'barbar'.setup {
  -- Enable/disable animations
  animation = false,

  -- Automatically hide the tabline when there are this many buffers left.
  -- Set to any value >=0 to enable.
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Add this block to create an offset for NERDTree
  sidebar_filetypes = {
    -- Set a text to appear in the sidebar section.
    nerdtree = {text = sidebarText},
  },

  -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
  -- Valid options are 'left' (the default), 'previous', and 'right'
  focus_on_close = 'previous',

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  hide = {extensions = false, inactive = false},

  -- ENable highlighting alternate buffers
  highlight_alternate = true,

  -- Disable highlighting file icons in inactive buffers
  highlight_inactive_file_icons = false,

  -- Enable highlighting visible buffers
  highlight_visible = true,
highlight = {
    current  = {fg = '#cacfd6ff', bg = '#5fffff', bold = true},
    visible  = {fg = '#a0a8d0', bg = '#1f2335'},
    inactive = {fg = '#6c7394', bg = '#16191f'},
  },

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = false,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = true,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    separator = {left = '▎', right = ''},

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = {button = '●'},
    pinned = {button = '', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    -- 'tabline' will make barbar use the standard TabLine highlights, making it
    -- compatible with any colorscheme.
    -- This is being removed to fix the missing tabline and re-enable sidebar offsets.
    --preset = 'tabline',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- Sets the minimum buffer name length.
  minimum_length = 0,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,

  -- sorting options
  sort = {
    -- tells barbar to ignore case differences while sorting buffers
    ignore_case = true,
  },
}


-- Unique names

-- Sidebar offsets

-- Underline indicator

-- Alternate styling


local function apply_barbar_highlights()
  local link_sets = {
    TabLineSel = {
      'BufferCurrent', 'BufferCurrentIndex', 'BufferCurrentMod', 'BufferCurrentSign',
      'BufferCurrentTarget', 'BufferCurrentIcon', 'BufferCurrentNumber',
      'BufferCurrentHINT', 'BufferCurrentINFO', 'BufferCurrentWARN', 'BufferCurrentERROR',
      'BufferDefaultCurrent', 'BufferDefaultCurrentIndex', 'BufferDefaultCurrentMod',
      'BufferDefaultCurrentSign', 'BufferDefaultCurrentTarget', 'BufferDefaultCurrentIcon',
      'BufferDefaultCurrentNumber', 'BufferDefaultCurrentHINT', 'BufferDefaultCurrentINFO',
      'BufferDefaultCurrentWARN', 'BufferDefaultCurrentERROR',
    },
    TabLine = {
      'BufferVisible', 'BufferVisibleIndex', 'BufferVisibleMod', 'BufferVisibleSign',
      'BufferVisibleTarget', 'BufferVisibleIcon', 'BufferVisibleNumber',
      'BufferVisibleHINT', 'BufferVisibleINFO', 'BufferVisibleWARN', 'BufferVisibleERROR',
      'BufferDefaultVisible', 'BufferDefaultVisibleIndex', 'BufferDefaultVisibleMod',
      'BufferDefaultVisibleSign', 'BufferDefaultVisibleTarget', 'BufferDefaultVisibleIcon',
      'BufferDefaultVisibleNumber', 'BufferDefaultVisibleHINT', 'BufferDefaultVisibleINFO',
      'BufferDefaultVisibleWARN', 'BufferDefaultVisibleERROR',
    },
    TabLineFill = {
      'BufferInactive', 'BufferInactiveIndex', 'BufferInactiveMod', 'BufferInactiveSign',
      'BufferInactiveTarget', 'BufferInactiveIcon', 'BufferInactiveNumber',
      'BufferInactiveHINT', 'BufferInactiveINFO', 'BufferInactiveWARN', 'BufferInactiveERROR',
      'BufferDefaultInactive', 'BufferDefaultInactiveIndex', 'BufferDefaultInactiveMod',
      'BufferDefaultInactiveSign', 'BufferDefaultInactiveTarget', 'BufferDefaultInactiveIcon',
      'BufferDefaultInactiveNumber', 'BufferDefaultInactiveHINT', 'BufferDefaultInactiveINFO',
      'BufferDefaultInactiveWARN', 'BufferDefaultInactiveERROR',
      'BufferTabpages', 'BufferTabpageFill',
    },
  }

  for target, groups in pairs(link_sets) do
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { link = target })
    end
  end
end

local group = vim.api.nvim_create_augroup('BarbarTablineSync', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = function() vim.schedule(apply_barbar_highlights) end,
})

vim.schedule(apply_barbar_highlights)
