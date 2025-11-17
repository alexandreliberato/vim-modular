""""""""""""""""""""
"      UX CONF     "
""""""""""""""""""""



" ------------------------------------------------------
" Level 0

" stop ux.vim loading if already loaded (prevents verbose spam under -V)
if exists('g:loaded_ux')
  finish
endif
let g:loaded_ux = 1

" vim: Leader key
let mapleader=" "

" load ux extensions
lua pcall(require,'extensions.ux.buffers')
lua pcall(require,'extensions.ux.bottom_line')
lua pcall(require,'extensions.ux.search')
lua pcall(require,'extensions.ux.diagrams')
lua pcall(require,'extensions.ux.git')
lua pcall(require,'extensions.ux.autocomplete')
lua pcall(require,'extensions.ux.sessions')
lua pcall(require,'extensions.ux.context')

" load Telescope extensions
lua pcall(function() require('telescope').load_extension('fzf') end)
lua pcall(function() require('telescope').load_extension('git_grep') end)
lua pcall(function() require('telescope').load_extension('frecency') end)



" ----------------------------------------------------
" Level 01 - Very High Impact

" nerdtree: File explorer width
:let g:NERDTreeWinSize=45

" vim: show numbers
set number

" does not exits when deleting a buffer
command! BD bn | bd #

" ----------------------------------------------------
"  Level 02 - High Impact

"
" VIM
"

" vim: change colorscheme based on filetype
"autocmd FileType vim colorscheme monokai
"
" vim: buffer title
" TODO: bufferline plugin overwrites it?
set titlestring=%t%m\ -\ %{v:progname}\ (%{tabpagenr()}})

" vim: hide til (~) where there is no buffer lines using space instead til
set fillchars=eob:\ 

" vim: left margin
set foldcolumn=3
set foldmethod=manual

" Alternar exibição de numero de linhas (facilita na hora de copiar)
nnoremap  :set nonumber!: set foldcolumn=0

" vim: copy to clipboard
set clipboard+=unnamedplus

" vim: use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"
" Telescope
"

" Local errors
nnoremap <silent> <leader>d :Telescope diagnostics bufnr=0<CR>

" Global errors
nnoremap <silent> <leader>D :Telescope diagnostics<CR>


"
" NERDTree: a filer explorer
"

" Hide til (~) 
let NERDTreeIgnore = ['\.til$', '\~$', '\.swp$']

" Respect Vim's built-in wildignore settings as well
set wildignore+=*.til,*.swp,*~
let NERDTreeRespectWildIgnore=1

function! NerdTreeToggleFind()
  if filereadable(expand('%'))
    NERDTreeFind
  else
    NERDTree
  endif
endfunction

" Shows filename in statusline -> auto
let g:NERDTreeStatusline = "%{exists('g:NERDTreeFileNode')&&" .
      \ "has_key(g:NERDTreeFileNode.GetSelected(),'path')?" .
      \ "g:NERDTreeFileNode.GetSelected().path.getLastPathComponent(0):''}"

" Reveals/Selects file in NERDTree/File Explorer -> ;nf
"nnoremap <silent> <leader>nf :NERDTreeFind<CR>
nnoremap <silent> <leader>nr :call NerdTreeToggleFind()<CR>

" Toggle NERDTree
" Can't get <C-Space> by itself to work, so this works as Ctrl - space - space
" https://github.com/neovim/neovim/issues/3101
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim#answer-24550772
"nnoremap <C-Space> :NERDTreeToggle<CR>
"nmap <C-@> <C-Space>
nnoremap <silent> <Space>e :NERDTreeToggle<CR>

" open directory using 'L', only when in nerdtree
"did not worked
"nnoremap <silent> l o<CR>
autocmd FileType nerdtree nmap <buffer> l o


" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" ----------------------------------------------------
" Others




" The following can be commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set termguicolors
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set nocursorcolumn           " speed up syntax highlighting
set updatetime=300
set pumheight=10             " Completion window max size
set conceallevel=2           " Concealed text is completely hidden

" Relax file compatibility restriction with original vi
" (not necessary to set with neovim, but useful for vim)
set nocompatible

" Disable beep / flash
set vb t_vb=

" highlight matches when searching
" Use C-l to clear (see key map section)
set hlsearch

" Line numbering
" TODO: add shortcut to README
set nonumber

" Disable line wrapping
" Toggle set to ';w' in key map section
set nowrap

" enable line and column display
set ruler

"disable showmode since using vim-airline; otherwise use 'set showmode'
"set noshowmode

" file type recognition
filetype on
filetype plugin on
filetype indent on

" TODO: study
set nowrap


" Always display the status line
set laststatus=2

" Enable highlighting of the current line
set cursorline

" scroll a bit horizontally when at the end of the line
set sidescroll=6


" TODO: understand and add comment
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" Automatically resize screens to be equally the same
autocmd VimResized * wincmd =

" don't use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" really, just don't
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap ;; <ESC>


" navigate between errors
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>





"
" General: other nvim configs
"

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>

" toggle line wrap
nnoremap <silent> <leader>w :set wrap! wrap?<CR>

" ----------------------------
"                             " 
"" BUFFERS                    "
"                             "

" 1)
" Make it easier to work with buffers
" http://vim.wikia.com/wiki/Easier_buffer_switching
set hidden
set confirm
set autowriteall
set wildmenu wildmode=full


" 2) 
" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>

" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-l> :bn<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>
" https://github.com/neovim/neovim/issues/2048
nnoremap <C-h> :bp<CR>

" close buffer
nnoremap <silent> <leader>bd :BD<CR>

" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>

" list buffers
nnoremap <silent> <leader>bl :ls<CR>
" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>

" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>

" redraw screan and clear search highlighted items
"http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" improved keyboard navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" improved keyboard support for navigation (especially terminal)
" https://neovim.io/doc/user/nvim_terminal_emulator.html
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> <leader>tt :terminal<CR>
nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
nnoremap <silent> <leader>th :new<CR>:terminal<CR>
tnoremap <C-x> <C-\><C-n><C-w>q


" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree it
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) 

" Refresh the current folder if any changes
autocmd BufEnter NERD_tree_* | execute 'normal R'
au CursorHold * if exists("t:NerdTreeBufName") | call function('s:refreshRoot')() | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0

" dont show message: Please wait caching large directory
let g:NERDTreeNotificationThreshold = 500
let NERDTreeShowHidden=1

" Exit Vim if NERDTree is the only window remaining in the only tab.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" show file lines
"let g:NERDTreeFileLines = 1




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

" COC
" improve CoC usage
set nobackup
set nowritebackup
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif



" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



" (search) configure FZF and rg
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{js,kt,json,php,vim,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,scss}" -g "!*.{min.js,swp,o,zip}" -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command.shellescape(<q-args>), 1, <bang>0)

" FZF shortcut 
nnoremap <C-P> :Rg<CR>

" vim: Find files
" (x) already using Telescope
"nnoremap <silent> <Leader>f :Files<CR> 

" fzf: escape inside fzf window
if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif

" 
" identation
"
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" moving
"
" Mover no modo insert sem as setas
inoremap <C-b> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" simple vertical split
" vv to generate new vertical split
nnore map <silent> vv <c-w>v</c-w></silent>

augroup filetypedetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf

  autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl
  
  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.fish setlocal expandtab shiftwidth=2 tabstop=2
  
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END




