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
" lua pcall(require,'extensions.ux.buffers') " This line has been moved to init.vim
" lua pcall(require,'extensions.ux.sessions') " This line has been moved to init.vim
lua pcall(require,'extensions.ux.bottom_line')
lua pcall(require,'extensions.ux.search')
lua pcall(require,'extensions.ux.diagrams')
lua pcall(require,'extensions.ux.git')
lua pcall(require,'extensions.ux.autocomplete')
lua pcall(require,'extensions.ux.context')
lua pcall(require,'extensions.ux.keymap')
lua pcall(require,'extensions.ux.scrolling')
lua pcall(require,'extensions.ux.diagnostics')
lua pcall(require,'extensions.ux.find_and_replace')
lua pcall(require,'extensions.ux.terminal')
lua pcall(require,'extensions.ux.search_in_file')

" load Telescope extensions
lua pcall(function() require('telescope').load_extension('fzf') end)
lua pcall(function() require('telescope').load_extension('git_grep') end)
lua pcall(function() require('telescope').load_extension('frecency') end)
lua pcall(function() require('telescope').load_extension('coc') end)
"lua pcall(function() require('telescope').load_extension('noice') end)
" not usable yet
lua pcall(function() require('telescope').load_extension('notify') end)
lua pcall(function() require('telescope').load_extension('live_grep_args') end)


" ----------------------------------------------------
" Level 01 - Very High Impact

" CENTER LINE ALWAYS: without plugin
" Avoids updating the screen before commands are completed
"set lazyredraw

" Remap navigation commands to center view on cursor using zz
" nnoremap <C-U> 11kzz
" nnoremap <C-D> 11jzz
" nnoremap j jzz
" nnoremap k kzz
" nnoremap # #zz
" nnoremap * *zz
" nnoremap n nzz
" nnoremap N Nzz

" CENTER LINE: Center line when using zz in last line.
" ===========
"
" - Works even in insert mode

" a) Every time you enter in insert mode the screen gets vertically centered.
autocmd InsertEnter * norm zz

" b) Keep cursor centered even at the end of the file
nnoremap j jzz
nnoremap k kzz

" c) keep center after switch buffers
augroup CenterOnSwitch
  autocmd!
  autocmd BufWinEnter * call timer_start(10, {-> execute('normal! zz')})
augroup END

" Using both (a) and (b) it works very well

" END ----------------

" ---

" vim: show numbers
set number

" does not exits when deleting a buffer
" OLD:
" command! BD bn | bd #


" Track the two most recent buffers so <leader>bb always jumps to the last *living* buffer.
let g:buffer_history = []
let g:deleting_buffer = 0

augroup TrackLastBuffer
  autocmd!
  autocmd BufEnter * call s:TrackBuffer()
augroup END

function! s:TrackBuffer() abort
  " Skip tracking during buffer deletion and for non-file buffers
  if g:deleting_buffer | return | endif
  let l:buf = bufnr('%')
  if !buflisted(l:buf) | return | endif
  " Remove this buffer from history if already present, then prepend it
  call filter(g:buffer_history, 'v:val != ' . l:buf)
  call insert(g:buffer_history, l:buf, 0)
  " Keep only last 10 entries
  if len(g:buffer_history) > 10
    let g:buffer_history = g:buffer_history[:9]
  endif
endfunction

function! s:GoToLastBuffer() abort
  " Find the first buffer in history that is still listed and not the current one
  for l:buf in g:buffer_history
    if buflisted(l:buf) && l:buf != bufnr('%')
      execute 'buffer' l:buf
      return
    endif
  endfor
  echo "No previous buffer to switch to"
endfunction
command! GoLastBuffer call s:GoToLastBuffer()

function! s:SmartBufferDelete() abort
  let l:curbuf = bufnr('%')
  let g:deleting_buffer = 1
  " Find the best buffer to switch to before deleting
  let l:target = -1
  for l:buf in g:buffer_history
    if buflisted(l:buf) && l:buf != l:curbuf
      let l:target = l:buf
      break
    endif
  endfor
  if l:target != -1
    execute 'buffer' l:target
    execute 'bdelete' l:curbuf
  else
    execute 'bdelete' l:curbuf
    execute 'Startify'
  endif
  " Remove the deleted buffer from history
  call filter(g:buffer_history, 'v:val != ' . l:curbuf)
  let g:deleting_buffer = 0
endfunction
command! BD call s:SmartBufferDelete()


" ----------------------------------------------------
"  Level 02 - High Impact

"
" COPILOT: CHAT
" Changed from <leader>c to <leader>cc to avoid conflicts with register commands (e.g., "cy, "ay, etc.)
"
nnoremap <silent> <leader>cc :CopilotChatToggle<CR>

"
" CLAUDE CODE
"
"Toggle Claude"
nnoremap <silent> <leader>ac :ClaudeCode<cr> 
" Focus Claude"
nnoremap <silent> <leader>af :ClaudeCodeFocus<cr>
" Resume Claude"
nnoremap <silent> <leader>ar :ClaudeCode --resume<cr>
" Continue Claude"
nnoremap <silent> <leader>aC :ClaudeCode --continue<cr>
" Select Claude model"
nnoremap <silent> <leader>am :ClaudeCodeSelectModel<cr>
" Add current buffer"
nnoremap <silent> <leader>ab :ClaudeCodeAdd %<cr>
" Send to Claude"
nnoremap <silent> <leader>as :ClaudeCodeSend<cr>

"
" VIM
"

" move buffers at same time
nnoremap <silent> <F5> :windo normal! j<CR>
nnoremap <silent> <F6> :windo normal! k<CR>


" reload vim config
nnoremap <silent> <leader>vs :source $HOME/.config/nvim/init.vim<CR>

" write using leader
nnoremap <silent> <leader>w :w<CR>

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

" Alternar exibição de número de linhas (facilita na hora de copiar)
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
"https://github.com/neoclide/coc.nvim/wiki/Using-coc-list
nnoremap <silent> <leader>d :Telescope coc diagnostics<CR>

" Global errors
nnoremap <silent> <leader>D :CocList diagnostics<CR>


"
" NERDTree: a filer explorer
"

" Compute project root (prefer radix.nvim/git root, fallback to current file dir)
let g:debug_project_root = get(g:, 'debug_project_root', 0)

function! s:DebugProjectRoot(msg) abort
  if get(g:, 'debug_project_root', 0)
    " Avoid spamming floating notifications during startup unless explicitly enabled.
    call v:lua.vim.notify(a:msg)
  endif
endfunction

function! ProjectGitRoot() abort
  " Start from current file directory when possible
  let l:start = expand('%:p:h')
  if empty(l:start)
    let l:start = getcwd()
  endif

  " Cache to avoid repeated root computation (common during startup/autocmd bursts)
  if exists('s:cached_project_root_start')
        \ && s:cached_project_root_start ==# l:start
        \ && exists('s:cached_project_root')
        \ && type(s:cached_project_root) == v:t_string
        \ && !empty(s:cached_project_root)
    return s:cached_project_root
  endif

  " Try radix.nvim first (uses git root + other patterns)
  try
    let l:root = luaeval("require('radix').get_root_dir(_A)", l:start)
    if type(l:root) == v:t_string && !empty(l:root)
      let s:cached_project_root_start = l:start
      let s:cached_project_root = l:root
      return l:root
    endif
  catch
  endtry

  " Fallback: plain git from that directory
  let l:cmd = 'cd ' . shellescape(l:start) . ' && git rev-parse --show-toplevel'
  let l:git_root = systemlist(l:cmd)[0]
  if v:shell_error == 0 && !empty(l:git_root)
    let s:cached_project_root_start = l:start
    let s:cached_project_root = l:git_root
    return l:git_root
  endif

  " Last resort: starting directory
  let s:cached_project_root_start = l:start
  let s:cached_project_root = l:start
  return l:start
endfunction

function! OpenNERDTreeAtProjectRoot() abort
  let l:root = ProjectGitRoot()
  execute 'NERDTree' fnameescape(l:root)
endfunction

" Reveal file
function! NerdTreeToggleFind()
  if filereadable(expand('%'))
    " Open rooted at git root, then reveal current file
    "call OpenNERDTreeAtProjectRoot()
    NERDTreeFind
  else
    " No file, just open at git root
    call OpenNERDTreeAtProjectRoot()
  endif
endfunction

nnoremap <silent> <leader>er :call NerdTreeToggleFind()<CR>

" Width
let g:NERDTreeWinSize=45

" Hide character '~' 
let NERDTreeIgnore = ['\.til$', '\~$', '\.swp$']

" Respect Vim's built-in wildignore settings as well
set wildignore+=*.til,*.swp,*~
let NERDTreeRespectWildIgnore=1

" Filename in statusline 
let g:NERDTreeStatusline = "%{exists('g:NERDTreeFileNode')&&" .
      \ "has_key(g:NERDTreeFileNode.GetSelected(),'path')?" .
      \ "g:NERDTreeFileNode.GetSelected().path.getLastPathComponent(0):''}"

" Open/Close keymap
nnoremap <silent> <Space>e :NERDTreeToggle<CR>

" Enter a directory using 'L' 
autocmd FileType nerdtree nmap <buffer> l o

" Auto refresh directory (disabled: caused issues with auto-session + empty buffers)
"autocmd BufEnter NERD_tree_* | execute 'normal R'
"au CursorHold * if exists("t:NerdTreeBufName") | call function('s:refreshRoot')() | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
augroup NerdTreeWindowGuard
  autocmd!
  autocmd BufEnter * call <SID>NerdTreeWindowGuard()
augroup END

function! s:NerdTreeWindowGuard() abort
  " Guard against recursion and avoid acting on plugin/floating windows
  if exists('s:nt_guard_running')
    return
  endif
  if winnr('$') <= 1
    return
  endif
  if &buftype !=# ''
    return
  endif
  if &filetype ==# 'notify' || &filetype ==# 'TelescopePrompt'
    return
  endif

  if bufname('#') !~# '^NERD_tree_\d\+$'
    return
  endif
  if bufname('%') =~# '^NERD_tree_\d\+$'
    return
  endif

  let s:nt_guard_running = 1
  try
    let l:buf = bufnr('%')
    " Restore NERDTree in the current window
    silent! buffer #

    " Move to a different window and open the intended buffer there
    wincmd w
    execute 'buffer ' . l:buf
  finally
    unlet s:nt_guard_running
  endtry
endfunction

" Hide message: Please wait caching large directory
let g:NERDTreeNotificationThreshold = 500
let NERDTreeShowHidden=1

" Show file lines
"let g:NERDTreeFileLines = 1

" ?? CONFIGURE NERD TREE FUNCTIONS
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


" ----------------------------------------------------
" Level 3: Others

" PlantUML keymaps
nnoremap <silent> <leader>po :PlantumlOpen<cr>

" enable spell checking
" commands:
"   zg  - adds to the dictionary
"   zug - removes from the dictionary
"   s[  - searchs for problems up
"   ]s  - searchs for problems down
set spell spelllang=en

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
set synmaxcol=300           " stop syntax highlight on very long lines (tokens, minified files)
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
"autocmd BufEnter * silent! lcd %:p:h

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
"map <C-n> :cnext<CR>
"map <C-m> :cprevious<CR>
"nnoremap <leader>a :cclose<CR>





"
" General: other nvim configs
"

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>

" toggle line wrap
" nnoremap <silent> <leader>w :set wrap! wrap?<CR>

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
" close all but current
nnoremap <silent> <leader>ba :BufferCloseAllButCurrent<CR>

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb :GoLastBuffer<CR>

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

" redraw screen and clear search highlighted items
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

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes


" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)


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

" Quit inteligente: fecha o Neovim inteiro com :q em buffers normais.
" Se estiver no NERDTree, fecha só aquela janela.
function! s:IsNerdTreeBuf(name) abort
  " Qualquer buffer cujo nome combine com NERD_tree_* é NERDTree
  return a:name =~# 'NERD_tree_\d\+'
endfunction

function! s:SmartQuit() abort
  let l:curr_name = bufname('%')

  " 1) Se estou em uma janela do NERDTree, só fecha essa janela
  if s:IsNerdTreeBuf(l:curr_name)
    quit
    return
  endif

  " 2) Verifica se existe ao menos uma janela NERDTree aberta
  " TODO: se não for o buffer de código(.py, .go, etc) fecho apenas o buffer
  " atual que pode ser um plugin.
  let l:has_nerdtree = bufwinnr('NERD_tree_1') > 0
  if !l:has_nerdtree
    " Não tem NERDTree aberto -> fecha o Neovim inteiro
    qa
    return
  endif

  " 3) Tem NERDTree aberto e estou em outro buffer:
  "    fecha o(s) NERDTree(s) e depois sai de tudo
  for l:w in range(1, winnr('$'))
    let l:buf = winbufnr(l:w)
    let l:name = bufname(l:buf)
    if s:IsNerdTreeBuf(l:name)
      execute l:w . 'wincmd c'
    endif
  endfor

  " Agora fecha o Neovim inteiro
  qa
endfunction

command! SmartQuit call <SID>SmartQuit()

" Se o usuário digitou exatamente :q, troca por :SmartQuit
cnoreabbrev <expr> q (getcmdtype() ==# ':' && getcmdline() ==# 'q') ? 'SmartQuit' : 'q'

" NOTE: NERDTree opening on startup is now handled by sessions.lua
" to properly handle session restoration.

let g:NERDTreeChDirMode = 0

" After loading a session, ensure NERDTree is open at project root, but keep
" focus on the main code window.
function! s:EnsureNerdTreeAtRootAndFocusFile() abort
  " Debounce/guard: auto-session can trigger multiple events during startup.
  if exists('s:ensure_nerdtree_running')
    return
  endif
  let s:ensure_nerdtree_running = 1
  try
  " If cursor is currently in NERDTree, move to another window first.
  if s:IsNerdTreeBuf(bufname('%')) && winnr('$') > 1
    wincmd p
  endif

  " Remember the current (code) window and buffer using stable IDs.
  let l:code_winid = win_getid()
  let l:code_bufnr = bufnr('%')

  " Open or re-root NERDTree at the project git root.
  call OpenNERDTreeAtProjectRoot()

  " Go back to the code window (window numbers may have changed).
  call win_gotoid(l:code_winid)

  " Reveal the current file inside NERDTree, if this buffer is a real file.
  if buflisted(l:code_bufnr)
    execute 'buffer ' . l:code_bufnr
    if filereadable(expand('%'))
      NERDTreeFind
    endif
  endif

  " Finally, ensure focus stays on the code window.
  call win_gotoid(l:code_winid)
  finally
    unlet s:ensure_nerdtree_running
  endtry
endfunction

augroup AutoSessionFocus
  autocmd!
  autocmd SessionLoadPost * let g:session_restored = 1 | call <SID>EnsureNerdTreeAtRootAndFocusFile()
  autocmd User AutoSessionRestorePost * let g:session_restored = 1 | call <SID>EnsureNerdTreeAtRootAndFocusFile()
augroup END

" reveal the file and goes back to the root of the project simulating a manual directory change
function! NerdTreeRevealWithoutReroot() abort
  let l:project_root = ProjectGitRoot()
  " if nerd tree is open
  if exists("t:NerdTreeBufName") && bufwinnr(t:NerdTreeBufName) > 0
    if filereadable(expand('%'))
      NERDTreeFind
      " Go to NERDTree window
      exec bufwinnr(t:NerdTreeBufName) . 'wincmd w'
      
      " Move up and expand until project root is found or at root
      let l:max_up = 50
      while l:max_up > 0
        let l:curdir = get(b:, 'NERDTreeRoot', '')

        if l:curdir ==# l:project_root || l:curdir ==# ''
          break
        endif
        normal! h
        normal! o
        let l:max_up -= 1
      endwhile
      wincmd p
    endif
    return
  endif

  NERDTree
  if filereadable(expand('%'))
    NERDTreeFind
    exec bufwinnr(t:NerdTreeBufName) . 'wincmd w'
    let l:max_up = 50
    while l:max_up > 0
      let l:curdir = get(b:, 'NERDTreeRoot', '')
      if l:curdir ==# l:project_root || l:curdir ==# ''
        break
      endif
      normal! h
      normal! o
      let l:max_up -= 1
    endwhile
    wincmd p
  endif
endfunction

