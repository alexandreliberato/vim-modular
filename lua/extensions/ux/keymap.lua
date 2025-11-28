-- =====================================================================================
-- KEYMAP: 
--

-- Which key creates a map to help remember keymaps

local wk = require'which-key'.setup{
  event = "VeryLazy",
}

-- Create keymap groups
wk.add({
  { "e", group = "explorer",  desc="Explorer"}
})
