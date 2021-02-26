"
" Global Properties
"
let g:coc_global_extensions = ['coc-json', 'coc-git']

" 
" Utils
"

" file explorer
Plug 'scrooloose/nerdtree'
" show git status in NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" session support
" Plug 'tpope/vim-obsession'

" Languages Support Plugin
"  este plugin a principio serve para fazer o autocomplete
"  para diversas linguages, POREM pode fazer o papel de 
"  servidor de linguages LSP ou seja, auxilia a suportar
"  mais linguagens de forma melhor no vim.
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" UML 
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'


