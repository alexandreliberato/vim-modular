" =================================================================================
" UX PLUGINS

"
" PLUGINS FOR BETTER USER EXPERIENCE
"

" ----------------------------------------------------------------
" Status Bar
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'


" ----------------------------------------------------------------
" Fuzzy Search: Plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

" Telescope extensions

" faster fzf
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" search content withing git repository
Plug 'davvid/telescope-git-grep.nvim'
" search file priorization
Plug 'nvim-telescope/telescope-frecency.nvim'


" ----------------------------------------------------------------
" Themes: Plugins
"
Plug 'crusoexia/vim-monokai'
Plug 'blueshirts/darcula'
Plug 'navarasu/onedark.nvim'


"-----------------------------------------------------------------
"Tabs/Session: Plugins
"Plug "tiagovla/scope.nvim"

" Bufferline/Tabs
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

"-----------------------------------------------------------------
" GIT: Plugins

" Blame line
Plug 'tveskag/nvim-blame-line'

" ----------------------------------------------------------------
"  Context: Plugins
Plug 'https://github.com/nvim-treesitter/nvim-treesitter-context'
