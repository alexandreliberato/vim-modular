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


"
" Themes
"
Plug 'crusoexia/vim-monokai'
Plug 'blueshirts/darcula'


" CONFIGURE Fuzzy Search
nnoremap <C-P> :Files<CR>


let g:airline_theme='monochrome'

" CONFIGURE NERD TREE FUNCTIONS
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
	TagbarClose
	NERDTreeClose
        set foldcolumn=10

    else
	set foldcolumn=0
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2 
        set showcmd
	NERDTree
	" NERDTree takes focus, so move focus back to the right
	" (note: "l" is lowercase L (mapped to moving right)
	wincmd l
	TagbarOpen

    endif
endfunction

nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>


