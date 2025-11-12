" Installs Golang CoC plugin (language server, autocomplete, gopls)
"
call add(coc_global_extensions, 'coc-go')

"
" Installs Golang support for vim (syntax, build and debug)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"
" Plugins
Plug 'maxandron/goplements.nvim', { 'ft': 'go' }




