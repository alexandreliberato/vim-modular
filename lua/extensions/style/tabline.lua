-- sets current tab highlight color always that colorscheme is applied
local accent_map = {
  azul       = { fg = '#0c1324', bg = '#5fffff', bold = true },
  blue       = { fg = '#0c1324', bg = '#5fffff', bold = true },
  nightvision= { fg = '#071b00', bg = '#b8ff5a', bold = true },
  ['rose-pine'] = { fg = '#1f1d2e', bg = '#9ccfd8', bold = true },
  peachpuff  = { fg = '#fff2e6', bg = '#5a2e0a', bold = true },
  _default   = { fg = '#d6d7ff', bg = '#2f3bb8', bold = true },
}

local current_groups = {
  'BufferCurrent', 'BufferCurrentIndex', 'BufferCurrentMod', 'BufferCurrentSign',
  'BufferCurrentTarget', 'BufferCurrentIcon', 'BufferCurrentNumber',
  'BufferCurrentHINT', 'BufferCurrentINFO', 'BufferCurrentWARN', 'BufferCurrentERROR',
  'BufferDefaultCurrent', 'BufferDefaultCurrentIndex', 'BufferDefaultCurrentMod',
  'BufferDefaultCurrentSign', 'BufferDefaultCurrentTarget', 'BufferDefaultCurrentIcon',
  'BufferDefaultCurrentNumber', 'BufferDefaultCurrentHINT', 'BufferDefaultCurrentINFO',
  'BufferDefaultCurrentWARN', 'BufferDefaultCurrentERROR',
}

local accent = { fg = '#cacfd6', bg = '#005faf', bold = true }
for _, group in ipairs(current_groups) do
  vim.api.nvim_set_hl(0, group, accent)
end

local link_sets = {
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

local function apply_barbar_highlights()
  local scheme = vim.g.colors_name or ''
  local accent = accent_map[scheme] or accent_map._default

  for _, group in ipairs(current_groups) do
    vim.api.nvim_set_hl(0, group, accent)
  end

  for target, groups in pairs(link_sets) do
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { link = target })
    end
  end
end

local group = vim.api.nvim_create_augroup('BarbarTablineSync', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = function()
    vim.defer_fn(apply_barbar_highlights, 0)
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = function()
    vim.defer_fn(apply_barbar_highlights, 0)
  end,
})

vim.defer_fn(apply_barbar_highlights, 0)

