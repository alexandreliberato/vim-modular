"
" Installs Java CoC plugin (language server, autocomplete)
"
" (coc-pyright now listed in g:coc_global_extensions; removed early install call)

" References with Telescope
nnoremap <leader>zr :call CocAction('references')<CR>

" Implementations with Telescope
nnoremap <leader>zi :call CocAction('implementations')<CR>
