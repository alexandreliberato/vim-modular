-- ==================================================================================
-- (ON) LINE/COLUMN IDENTATION
require("indentmini").setup() -- use default config

--
-- OR
--

--[[
-- Colors are applied automatically based on user-defined highlight groups.
-- There is no default value.
vim.cmd.highlight('IndentLine guifg=#123456')
-- Current indent line highlight
vim.cmd.highlight('IndentLineCurrent guifg=#123456')
]]
