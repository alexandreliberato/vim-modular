"
" GLOBAL PROPERTIES
"

" 
" PLUGIN UTILS
"

" Vim Script Linting
Plug 'Vimjas/vint'

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter'

" File Explorer
Plug 'scrooloose/nerdtree'
"
" Show git status in NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Programming Languages Support Plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" UML 
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" GIT
Plug 'tpope/vim-fugitive'

" Tests
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'

" Sessions
Plug 'mhinz/vim-startify'

" Markdown 
" TODO: P0 - search for a good plugin

" Outline
Plug 'preservim/tagbar'

" Colorscheme/Theme selector
Plug 'zaldih/themery.nvim'

" LSP icons in autocomplete
Plug 'https://github.com/onsails/lspkind.nvim'

" NVIM LSP: Native
Plug 'https://github.com/neovim/nvim-lspconfig'

" Get root directory
Plug 'https://github.com/michel-garcia/radix.nvim'

" Telescope integration with coc
Plug 'https://github.com/fannheyward/telescope-coc.nvim'
" Arguments for Telescope
Plug 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim'

" Noice: Improved logging
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
"too experimental but i could use in the future
"Plug 'folke/noice.nvim'

" Session + git + automatically
Plug 'https://github.com/rmagatti/auto-session'

" Better scrolling
Plug 'karb94/neoscroll.nvim'

" Better  diagnostics
Plug 'https://github.com/folke/trouble.nvim'

" Find and replace
Plug 'https://github.com/MagicDuck/grug-far.nvim'

" Copilot: Suggestions and next autocomplete
"Plug 'copilotlsp-nvim/copilot-lsp'
"Plug 'zbirenbaum/copilot.lua'

" Copilot: Chat AI/IA/Artificial Intelligence
Plug 'CopilotC-Nvim/CopilotChat.nvim'

" SQLite support, used for Telescope
Plug 'kkharji/sqlite.lua'

" Debug
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'

" Debug UI
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

" Go2File: Improved gf/gF
" Better path solution
Plug 'HawkinsT/pathfinder.nvim'
" git.lua
"

" Tmux syntax
Plug 'ericpruitt/tmux.vim', {'rtp': 'vim/'}

" Lua formatter
Plug 'ckipp01/stylua-nvim'

" Generic linters: used for better spell:set scrolloff=10
Plug 'mfussenegger/nvim-lint'

" Claude Code 
Plug 'folke/snacks.nvim' " dependency
Plug 'coder/claudecode.nvim'
