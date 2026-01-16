-- -------------- --
-- SEARCH CONFIG  --
-- -------------- --

-- ! NOT WORKING, USING search.vim

-- MENU
-- - File Search 
-- - Content Search
local root_patterns = { ".git", "go.mod" }
local cwd = (vim.uv or vim.loop).cwd()
local found_root = vim.fs.find(root_patterns, { upward = true, path = cwd })[1]
local root_dir = found_root and vim.fs.dirname(found_root) or cwd
local actions = require('telescope.actions')
local has_sqlite = pcall(require, 'sqlite')
if not has_sqlite then
  vim.schedule(function()
    vim.notify('[telescope] install "kkharji/sqlite.lua" for persistent history', vim.log.levels.WARN)
  end)
end

require('telescope').setup{
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      layout_strategy = 'vertical',
      layout_config = { vertical = { preview_height = 0.65, prompt_position = 'bottom' } },
      dynamic_preview_title = true,
      path_display = function(_, path)
        if root_dir and path:sub(1, #root_dir) == root_dir then
          return path:sub(#root_dir + 2)
        end
        return path
      end,
      cwd = root_dir,
    },
    coc = {
        prefer_locations = false, -- always use Telescope locations to preview definitions/declarations/implementations etc
        push_cursor_on_edit = true, -- save the cursor position to jump back in the future
        timeout = 3000 -- timeout for coc commands   
    },
  },
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { vertical = { preview_height = 0.65, prompt_position = 'bottom' } },
    dynamic_preview_title = true,
    path_display = function(_, path)
      if root_dir and path:sub(1, #root_dir) == root_dir then
        return path:sub(#root_dir + 2)
      end
      return path
    end,
    cwd = root_dir,
    -- persistent prompt history (applies to live_grep_args, find files, etc.)
    history = has_sqlite and {
      path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      limit = 200,
    } or nil,
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
      n = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
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
     live_grep = {
       search_dirs = { root_dir },
     },
  },
}

-- Define telescope as a local variable for cleaner use
local builtin = require('telescope.builtin')

-- -----------------------------------------
-- Keymaps search
vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = 'Telescope Find Keymaps' })

-- -----------------------------------------
-- File Search
vim.keymap.set('n','<leader>f', builtin.git_files, { desc='Telescope Find Files' })

-- -------------------------------------------
-- Buffer Search
vim.keymap.set('n','<leader>b', builtin.buffers,    { desc='Telescope Buffers' })

-- -----------------------------------------
-- Content Search
--vim.keymap.set('n','<leader>s', builtin.live_grep_args, { desc='Telescope Search text' })

-- Content Search (dynamic args)
vim.keymap.set('n','<leader>s', function()
  require('telescope').extensions.live_grep_args.live_grep_args({
    search_dirs = { root_dir }, -- keep your git-root restriction
  })
end, { desc='Telescope Search text (args)' })

-- Key mapping to open comparison in two panels
vim.keymap.set('n', '<leader>vh', function()
  builtin.git_commits({
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        if selection then
          -- Show differences directly in a new split using Fugitive
          vim.cmd('Gdiffsplit ' .. selection.value)
        end
      end)
      return true
    end,
    -- Optionally, you can choose to show the commit message too
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = { mirror = false },
    },
  })
end, { desc = 'Fugitive Compare with History (Live in Telescope)' })


vim.keymap.set('n','<leader>vd', function()
  builtin.git_bcommits({
    attach_mappings = function(_, map)
      local open_diff = function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        actions.close(prompt_bufnr)
        if selection and selection.value then
          -- Use Fugitive/vimdiff as difftool for the current file
          vim.cmd('Gdiffsplit ' .. selection.value)

          -- To instead call your git *difftool* for the current file, use:
          -- vim.cmd('!git difftool ' .. selection.value .. ' -- ' .. vim.fn.expand('%'))
        end
      end

      map('i', '<CR>', open_diff)
      map('n', '<CR>', open_diff)
      return true
    end,
  })
end, { desc = 'Diff current file with selected commit' })
