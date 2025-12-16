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
  extensions = {
    coc = {
        prefer_locations = false, -- always use Telescope locations to preview definitions/declarations/implementations etc
        push_cursor_on_edit = true, -- save the cursor position to jump back in the future
        timeout = 3000 -- timeout for coc commands   
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      -- mappings = { -- extend mappings
      --   i = {
      --     ["<C-k>"] = lga_actions.quote_prompt(),
      --     ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
      --     -- freeze the current list and start a fuzzy search in the frozen list
      --     ["<C-space>"] = lga_actions.to_fuzzy_refine,
      --   },
      -- },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  },
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
vim.keymap.set('n','<leader>s', builtin.live_grep, { desc='Telescope Search text' })


