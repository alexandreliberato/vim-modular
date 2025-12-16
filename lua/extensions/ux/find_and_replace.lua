-- ===================================================================
-- FIND AND REPLACE
--

-- Configuration
require('grug-far').setup{}

local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

-- Keymaps
vim.keymap.set({ 'n', 'x' }, '<leader>fr', function()
  local search = vim.fn.getreg('/')
  -- surround with \b if "word" search (such as when pressing `*`)
  if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
    search = '\\b' .. search:sub(3, -3) .. '\\b'
  end
  require('grug-far').open({
    prefills = {
      search = search,
      paths = git_root,
    },
  })
end, { desc = 'grug-far: Search using @/ register value or visual selection' })


