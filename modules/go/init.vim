" Installs Golang CoC plugin (language server, autocomplete, gopls)
"
" (coc-go now listed in g:coc_global_extensions; removed early install call)

"
" Installs Golang support for vim (syntax, build and debug)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"
" Plugins
Plug 'maxandron/goplements.nvim', { 'ft': 'go' }




