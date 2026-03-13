-- =========================================================================
-- TERMINAL: Bottom panel terminal buffer
--
-- Opens a terminal in a horizontal split at the bottom of the code area,
-- without affecting NERDTree.

local terminal_bufnr = nil
local terminal_winid = nil

local function is_terminal_open()
  return terminal_winid
    and vim.api.nvim_win_is_valid(terminal_winid)
    and terminal_bufnr
    and vim.api.nvim_buf_is_valid(terminal_bufnr)
end

local function close_terminal()
  if is_terminal_open() then
    vim.api.nvim_win_close(terminal_winid, true)
  end
  terminal_winid = nil
end

local function open_terminal()
  -- If already open, just focus it
  if is_terminal_open() then
    vim.api.nvim_set_current_win(terminal_winid)
    vim.cmd('startinsert')
    return
  end

  -- Make sure we're not in NERDTree before splitting
  local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  if ft == 'nerdtree' then
    vim.cmd('wincmd l')
  end

  -- Open a horizontal split at the bottom with fixed height
  vim.cmd('botright ' .. 15 .. 'split')
  terminal_winid = vim.api.nvim_get_current_win()

  -- Reuse the existing terminal buffer if it's still valid
  if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
    vim.api.nvim_win_set_buf(terminal_winid, terminal_bufnr)
  else
    vim.cmd('terminal')
    terminal_bufnr = vim.api.nvim_get_current_buf()
  end

  -- Terminal-specific window options
  vim.wo[terminal_winid].number = false
  vim.wo[terminal_winid].relativenumber = false
  vim.wo[terminal_winid].signcolumn = 'no'
  vim.wo[terminal_winid].foldcolumn = '0'

  vim.cmd('startinsert')
end

local function toggle_terminal()
  if is_terminal_open() then
    close_terminal()
  else
    open_terminal()
  end
end

-- Keymaps
vim.keymap.set('n', '<leader>tj', toggle_terminal, { desc = 'Toggle bottom terminal' })
vim.keymap.set('t', '<leader>tj', function()
  vim.cmd('stopinsert')
  close_terminal()
end, { desc = 'Close bottom terminal' })

-- Prevent the terminal from showing in barbar's buffer list
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    if args.buf == terminal_bufnr then
      vim.bo[args.buf].buflisted = false
    end
  end,
})