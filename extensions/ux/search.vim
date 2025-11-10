""""""""""""""""""""
"   SEARCH CONF    "
"""""""""""""""""""

" MENU
" - File Search
" - Content Search

" -----------------------------------------
" File Search

"searchs from the current directory to bottom
"nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>

"search all files in the git repository, TODO: new files included?
" old: nnoremap <leader>f <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<CR>

" -----------------------------------------
" Buffers Search

" Map to buffers
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>

" -----------------------------------------
" ContentSearch

" search content using Telescope live_grep
nnoremap <leader>s <cmd>lua require('telescope.builtin').live_grep()<cr>

