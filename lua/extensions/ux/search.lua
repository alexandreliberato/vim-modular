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

-- Diagnostics
-- Workspace: TODO, not working
vim.keymap.set('n', 'D',          builtin.loclist, { desc = 'Workspace Diagnostics' })

-- Local
vim.keymap.set('n','<leader>d', function()
  require('telescope.builtin').loclist({
    attach_mappings = function(prompt_bufnr, map)
      local actions = require('telescope.actions')

      local function open_and_close_loclist()
        actions.select_default(prompt_bufnr)        -- jump to the location
        -- Defer closing so buffer switch is completed
        vim.schedule(function()
          pcall(vim.cmd, 'lclose')   -- hide location list window
        end)
      end

      map({'i','n'}, '<CR>', open_and_close_loclist)
      return true
    end
  })
end, { desc = 'Loclist (auto-close after select)' })

