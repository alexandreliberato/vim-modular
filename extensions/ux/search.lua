-- -------------- --
-- SEARCH CONFIG  --
-- -------------- --

-- ! NOT WORKING, USING search.vim

-- MENU
-- - File Search 
-- - Content Search

-- -----------------------------------------
-- File Search

-- Define telescope as a local variable for cleaner use
local builtin = require('telescope.builtin')

-- Key Mappings
-- Use vim.keymap.set for modern Neovim mapping

-- search all files in the git repository (Original <leader>f mapping)

-- Alternative: search from current directory (if preferred over git_files)

-- Map to buffers

-- Use an anonymous function to delay loading Telescope until the key is pressed
vim.keymap.set('n', '<leader>f', function()
  require('telescope.builtin').git_files()
end, { desc = 'Telescope Git Files' })

vim.keymap.set('n', '<leader>b', function()
  require('telescope.builtin').buffers()
end, { desc = 'Telescope Buffers' })

vim.keymap.set('n', '<leader>s', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Telescope Live Grep' })

-- -----------------------------------------
-- Content Search

-- search content using Telescope live_grep
vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'Telescope Live Grep' })


