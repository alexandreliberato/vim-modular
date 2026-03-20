" LOAD ALL CONFIGURATIONS MODULES
"

" optimize loading plugins
lua vim.loader.enable()

" Sessions: Restore session on VimEnter (MUST be before plug#begin)
lua pcall(require,'extensions.ux.sessions')

" -----------------------------------------------
"  INSTALL PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
    " Install Infrastructure Plugins
    source $HOME/.config/nvim/infra.vim
    " Install Extensions Plugins
    source $HOME/.config/nvim/ux-plugins.vim
    source $HOME/.config/nvim/style-plugins.vim
    " Install Language Plugins
    source $HOME/.config/nvim/modules/java.vim
    source $HOME/.config/nvim/modules/kotlin.vim
    source $HOME/.config/nvim/modules/python.vim
    source $HOME/.config/nvim/modules/elixir.vim
    source $HOME/.config/nvim/modules/plantuml.vim
    source $HOME/.config/nvim/modules/yaml.vim
    source $HOME/.config/nvim/modules/helm.vim
    source $HOME/.config/nvim/modules/vim.vim
    source $HOME/.config/nvim/modules/go/init.vim   
    luafile $HOME/.config/nvim/modules/lua.lua
call plug#end()

" Notifications UI (required for `:Telescope notify` history)
lua pcall(require,'extensions.infra.notify')

" Treesitter: Syntax highlighting and indentation
lua pcall(require,'extensions.infra.treesitter')

" Noice: Improved logging
"lua pcall(require,'extensions.infra.logger')

" Configure barbar.nvim immediately after it's loaded.
" This ensures it's ready before any autocommands use it.
lua pcall(require,'extensions.ux.buffers')

" Copilot suggestions
"lua pcall(require,'extensions.infra.copilot')

" Project root directory
lua pcall(require,'extensions.infra.directories')

" -----------------------------------------------
" Run Language Extensions
source $HOME/.config/nvim/languages.vim

lua pcall(require,'postgresql.postgres_lsp')
lua pcall(require,'golang.ux')

" Sleep: ensure everything is ready to be configured and used
call system("execute sleep 0.2")

" -----------------------------------------------
" Run UX and Style extensions
source $HOME/.config/nvim/style.vim
source $HOME/.config/nvim/ux.vim
source $HOME/.config/nvim/modules/go/ux.vim
source $HOME/.config/nvim/modules/go/keymaps.vim

" Enable debugging
lua << EOF
require('dap-go').setup({
  delve = {
    detached = false,
    path = "dlv",
    detached = false,
    cwd = vim.fn.getcwd(), -- Force current working directory
    port = "23451", -- Use a non-standard port
  },
})
EOF

lua require("dapui").setup()

" CONFIGURE markdown plugin
" TODO

" Copilot chat: Configure to avoid conflicts with Vim registers
lua << EOF
require("CopilotChat").setup({
  -- Use 'gy' prefix instead of 'y' to avoid conflicts with Vim registers
  -- Default selection behavior can interfere with "y register
  selection = 'unnamed',  -- Use unnamed register instead of visual selection
})
EOF


" Create a single startup function to run after everything is loaded.
function! s:FinalStartup()
  " 1. Open NERDTree only if no session was restored and no files were provided.
  if argc() == 0 && !exists("s:std_in") && !exists("g:session_restored")
    call OpenNERDTreeAtProjectRoot()
  endif

  " 2. Move cursor to the main window.
  wincmd p

  " 3. Force barbar.nvim to redraw.
  lua pcall(require'barbar'.force_redraw)
endfunction

" Create a function to set up the uv.nvim plugin.
function! s:SetupUV()
  lua require("uv").setup()
endfunction

" Defer the entire startup sequence until Neovim is idle.
" This is the most reliable way to avoid race conditions.
autocmd User PlugLoaded call timer_start(1, { -> s:FinalStartup() })
autocmd User PlugLoaded call timer_start(1, { -> s:SetupUV() })
