" ===================================================================================================
" STYLE
"

" This autocommand is causing startup errors because it runs before barbar.nvim is ready.
" The s:FinalStartup function in init.vim will handle the redraw correctly.
" autocmd ColorScheme * lua require'barbar'.force_redraw()

"load extensions
lua pcall(require,'extensions.style.line_column_ident')
lua pcall(require,'extensions.style.context')
lua pcall(require,'extensions.style.tabline')

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" ------------------------------------------------------------
" Set Colorscheme/Theme
"


" Manually set barbar's highlights to match the desired 'blue' theme.
" This is more robust than linking, as it prevents other themes from overwriting it.
"augroup BarbarThemeSync
"  autocmd!
"  "more green
"  autocmd ColorScheme blue
"    \ highlight BufferCurrent guifg=#000087 guibg=#5fffff |
"    \ highlight BufferInactive guifg=#000087 guibg=#008787 |
"    \ highlight BufferVisible guifg=#000087 guibg=#008787
"  "    more blue
"" autocmd ColorScheme blue
""    \ highlight BufferCurrent guifg=#ffffff guibg=#005faf |
""    \ highlight BufferInactive guifg=#5fffff guibg=#000087 |
""    \ highlight BufferVisible guifg=#5fffff guibg=#000087
"augroup END

" (x) Generic config
set nolist "hide indents

" -------------------------------------------
" (x) Colorscheme

" Default: azul
source $HOME/.config/nvim/colors/azul.vim

" Colors by language
autocmd BufWinEnter,Filetype python  ++nested colorscheme nightvision
autocmd BufWinEnter,Filetype golang  ++nested colorscheme blue
autocmd BufWinEnter,Filetype vim     ++nested colorscheme peachpuff
autocmd BufWinEnter,Filetype lua     ++nested colorscheme peachpuff
autocmd BufWinEnter,Filetype elixir  ++nested colorscheme rose-pine

" reload CoC colors after colorscheme change
autocmd ColorScheme * call Highlight()

function! Highlight() abort
  hi Conceal ctermfg=239 guifg=#504945
  hi CocSearch ctermfg=12 guifg=#18A3FF
  hi CocErrorHighlight gui=undercurl guisp=#ff3030 guifg=NONE guibg=NONE
endfunction

" -------------------------------------------
"
" ( ) Matrix NVim Colorscheme
" 
"let g:matrix_contrast = v:true "Make sidebars and popup menus like nvim-tree and telescope have a different background
"let g:matrix_borders = v:false "Enable the border between verticaly split windows visable
"let g:matrix_disable_background = v:false "Disable the setting of background color so that NeoVim can use your terminal background
"let g:matrix_cursorline_transparent	 = v:false "Set the cursorline transparent/visible
"let gmatrix_enable_sidebar_background	 = v:false "Re-enables the background of the sidebar if you disabled the background of everything
"let g:matrix_italic = v:false "enables/disables italics

"colorscheme matrix

" Lualine Colorscheme
"require('lualine').setup {
"  options = {
"    -- ... your lualine config
"    theme = 'matrix'
"    -- ... your lualine config
"  }
"}


" -------------------------------------------
"
" Helper: select dark/light schema
"

" ( ) colorscheme monokai
let g:onedark_config = {
    \ 'style': 'darker',
\}
" ( ) colorscheme onedark
" ( ) colorscheme blue

function! Light()
    echom "set bg=light"
    set bg=light
    colorscheme off
    set list
endfunction

function! Dark()
    echom "set bg=dark"
    set bg=dark
    colorscheme onedark
    "colorscheme blue
    "darcula fix to hide the indents:
    "set nolist
endfunction

function! ToggleLightDark()
  if &bg ==# "light"
    call Dark()
  else
    call Light()
  endif
endfunction

" toggle colors to optimize based on light or dark background
"nnoremap <leader>c :call ToggleLightDark()<CR>
"
""" Colorscheme/Theme selector

" Set list of theme and apply theme while picking. Default to true.
"TODO


" ==============================================================================================

"                                "
" AIRLINE BAR: COLORSCHEME/THEME "
"                                "


" ( ) General
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}

" ( ) Set theme
"let g:airline_theme='blue'
"let g:airline_theme='monochrome'
"let g:airline_theme='thematrix'
"let g:airline_theme='onedark'
"let g:airline_theme='violet'
"let g:airline_theme='powerlineish'


" show numbers when in code files
autocmd BufWinEnter *.go,*.py,*.js,*.ex setlocal number

