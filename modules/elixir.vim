"
" Installs Elixir CoC plugin (language server, autocomplete)
"

"
" Installs vim support for Elixir (syntax highlighting, indentation, etc)
"
Plug 'elixir-editors/vim-elixir'
syntax on
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
