-- =========================================================================
-- GIT: UX

-- Enable git blame at lines
vim.keymap.set('n','<leader>vb', ':ToggleBlameLine<CR>', { desc='Git Blame Line' })

-- Git log do arquivo atual
-- without telescope
--vim.keymap.set('n', '<leader>vf', ':Git log -- %<CR>', { desc = 'Git Log - Current File' })
-- with telescope
vim.keymap.set('n', '<leader>vf', ':Telescope git_bcommits<CR>', { desc = 'Git Log - Current File' })

-- Git log de todos os commits
vim.keymap.set('n', '<leader>va', ':Git log<CR>', { desc = 'Git Log - All' })


