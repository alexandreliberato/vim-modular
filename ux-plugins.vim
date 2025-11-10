""""""""""""""""""""
"    NVIM CONF     "
""""""""""""""""""""

"
" PLUGINS FOR BETTER USER EXPERIENCE
"

" ----------------------------------------------------------------
" Status Bar
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'


" ----------------------------------------------------------------
" Fuzzy Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

" Telescope extensions

" faster fzf
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }



" ----------------------------------------------------------------
" Themes
"
Plug 'crusoexia/vim-monokai'
Plug 'blueshirts/darcula'
Plug 'navarasu/onedark.nvim'


"Tabs and Session
"Plug "tiagovla/scope.nvim"

" Bufferline/Tabs
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
