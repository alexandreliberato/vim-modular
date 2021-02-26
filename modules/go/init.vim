"
" Installs Golang CoC plugin (language server, autocomplete, gopls)
"
call add(coc_global_extensions, 'coc-go')

"
" Installs Golang support for vim (syntax, build and debug)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jodosha/vim-godebug'

" >> configuring vim-go > https://github.com/fatih/vim-go
" =====================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let gkgo_highlight_build_constraints = 1


