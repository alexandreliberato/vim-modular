-- nvim-notify integration
--
-- `:Telescope notify` shows *nvim-notify's* notification history.
-- For that history to be populated, notifications must go through the
-- nvim-notify backend (i.e. `vim.notify = require('notify')`).

local ok, notify = pcall(require, 'notify')
if not ok then
  return
end

notify.setup({
  -- Keep it minimal/safe; customize later if you want.
  stages = 'fade',
  timeout = 2000,
  max_height = function()
    return math.floor(vim.o.lines * 0.25)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.5)
  end,
})

vim.notify = notify

-- Optional: ensure the Telescope picker is available once Telescope is loaded.
pcall(function()
  require('telescope').load_extension('notify')
end)
