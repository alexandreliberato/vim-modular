" ===================================================================================================
" STYLE
"

"load extensions
lua pcall(require,'extensions.style.line_column_ident')
lua pcall(require,'extensions.style.context')

" Treesitter + rainbow (required for rainbow-delimiters to work in Go)
lua <<EOF
local ok = pcall(require,'nvim-treesitter.configs')
if ok then
  require('nvim-treesitter.configs').setup{
    ensure_installed = { 'lua','go','vim','bash','python','javascript','json','yaml','html','toml' },
    highlight = { enable = true },
  }
end
EOF


"
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" ------------------------------------------------------------
" Set Colorscheme/Theme
"                       "

" (x) Generic config
set nolist "hide indents

" -------------------------------------------
"
" (x) Blue NVim Colorscheme
" 
colorscheme blue
" set matching parentheses colors
highlight MatchParen gui=underline guibg=black guifg=NONE
highlight CursorLine ctermbg=White
highlight iCursorLine ctermbg=LightBlue

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


