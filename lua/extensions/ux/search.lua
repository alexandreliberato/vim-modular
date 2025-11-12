-- -------------- --
-- SEARCH CONFIG  --
-- -------------- --

-- ! NOT WORKING, USING search.vim

-- MENU
-- - File Search 
-- - Content Search
local root_patterns = { ".git", "go.mod" }
local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

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
  },
  pickers = {
     -- search content of all files in the current git directory
     live_grep = {
       search_dirs = { root_dir },
     },
  },
}

-- Define telescope as a local variable for cleaner use
local builtin = require('telescope.builtin')

-- -----------------------------------------
-- File Search
vim.keymap.set('n','<leader>f', builtin.git_files, { desc='Telescope Find Files' })

-- -------------------------------------------
-- Buffer Search
vim.keymap.set('n','<leader>b', builtin.buffers,    { desc='Telescope Buffers' })

-- -----------------------------------------
-- Content Search
vim.keymap.set('n','<leader>s', builtin.live_grep)

-- Quickfix Search
vim.keymap.set('n','<leader>l', builtin.loclist)


