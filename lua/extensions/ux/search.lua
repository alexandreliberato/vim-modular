-- -------------- --
-- SEARCH CONFIG  --
-- -------------- --

-- ! NOT WORKING, USING search.vim

-- MENU
-- - File Search 
-- - Content Search
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { 
      "node_modules",
      "*/vendor/"
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob',
      '!**/vendor/**' -- This line excludes the vendor directory
    },
  }
}

-- Define telescope as a local variable for cleaner use
local builtin = require('telescope.builtin')

-- -----------------------------------------
-- File Search
vim.keymap.set('n','<leader>f', builtin.find_files, { desc='Telescope Find Files' })

-- -------------------------------------------
-- Buffer Search
vim.keymap.set('n','<leader>b', builtin.buffers,    { desc='Telescope Buffers' })

-- -----------------------------------------
-- Content Search
vim.keymap.set('n','<leader>s', builtin.live_grep)

--vim.keymap.set({'n', 'v'}, '<leader>s', function()
--    require('git_grep').workspace_live_grep()
--end)
--
--vim.keymap.set({'n', 'v'}, '<leader>S', function()
--    require('git_grep').workspace_grep()
--end)
--
--vim.keymap.set({'n', 'v'}, '<leader>z', function()
--    require('git_grep').live_grep()
--end)


