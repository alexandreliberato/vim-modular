-- ===========================================================
-- STYLE: Line/Column Identation
--
-- When we style the identation it help us to identify the code depth 
-- and where a block starts and finishes.
--
-- if x != y {
-- | print x
-- | print y
-- | if x == z {
-- | | print z
-- | }
-- }

-- set colors for ident lines
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })  -- pink (now for scope)
    vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })  -- blue (now for indent)
    -- keep others defined (optional)
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
end)

-- Only blue for all indentation guides; only pink for active scope
require("ibl").setup {
    indent = { highlight = { "RainbowBlue" } },
    -- (off) multiple colors
    --indent = { highlight = highlight },

    scope  = { enabled = true, highlight = { "RainbowRed" } },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

-- set delimiter for scope
vim.g.rainbow_delimiters = { highlight = highlight }

-- rainbow delimiters integration
-- if x = y {
-- _________
-- |
-- |
-- }
require('rainbow-delimiters.setup').setup {}
