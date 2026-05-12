-- =========================================================================
-- SCROLLING
--

require('neoscroll').setup({
  mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
    '<C-u>',
    '<C-b>', '<C-f>',
    '<C-y>', '<C-e>',
    'zt', 'zz', 'zb',
  },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = false,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  duration_multiplier = 1.0,   -- Global duration multiplier
  easing = 'linear',           -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = function(info)   -- Re-center cursor line after scrolls flagged with info = 'center'
    if info == 'center' then
      vim.cmd('normal! zz')
    end
  end,
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
  ignored_events = {           -- Events ignored while scrolling
      'WinScrolled', 'CursorMoved'
  },
})

-- <C-d>: scroll half-page down and keep the cursor line centered
vim.keymap.set({ 'n', 'x' }, '<C-d>', function()
  require('neoscroll').ctrl_d({ duration = 100, info = 'center' })
end, { silent = true })
