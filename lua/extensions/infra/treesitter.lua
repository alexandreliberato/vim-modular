-- =========================================================================
-- TREESITTER CONFIGURATION

local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  vim.notify('nvim-treesitter not available. Install with :PlugInstall', vim.log.levels.WARN)
  return
end

configs.setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    'vim',
    'vimdoc',
    'lua',
    'python',
    'go',
    'java',
    'kotlin',
    'yaml',
    'sql',
    'elixir',
    'markdown',
    'markdown_inline',
    'json',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  -- Syntax highlighting
  highlight = {
    enable = true,
    -- Disable treesitter highlight for specific filetypes if there are errors
    disable = function(lang, buf)
      -- ALWAYS disable for vim/vimdoc to avoid "Invalid node type substitute" error
      -- This is a known issue with vim parser queries
      if lang == 'vim' or lang == 'vimdoc' then
        return true
      end
      -- Also disable for large files
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      return false
    end,
    -- Use vim regex for vim files instead of treesitter
    additional_vim_regex_highlighting = true,
  },

  -- Indentation based on treesitter
  indent = {
    enable = true,
  },

  -- Autocmd to update parsers on demand
  autotag = {
    enable = false,
  },
})
