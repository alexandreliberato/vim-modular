"
" Installs Java CoC plugin (language server, autocomplete)
"
call add(g:coc_global_extensions, 'coc-pyright')

" References with Telescope
nnoremap <leader>zr :call CocAction('references')<CR>

" Implementations with Telescope
nnoremap <leader>zi :call CocAction('implementations')<CR>
