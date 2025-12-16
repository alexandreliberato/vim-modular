-- enables postgres language server (https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#postgres_lsp)
vim.lsp.enable('postgres_lsp')

vim.lsp.config('postgres_lsp', {
  cmd = { '/home/alexandre.macedo/.local/bin/pg-pls' },
  root_markers = {'.git'}
})
