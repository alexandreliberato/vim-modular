"
" Installs Java CoC plugin (language server, autocomplete)
"
call add(g:coc_global_extensions, 'coc-pyright')

" identation pep8 python
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

