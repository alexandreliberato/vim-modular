" LOAD ALL CONFIGURATIONS MODULES

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

" Noice: Improved logging
lua pcall(require,'extensions.infra.logger')

" Configure barbar.nvim immediately after it's loaded.
" This ensures it's ready before any autocommands use it.
lua pcall(require,'extensions.ux.buffers')

" -----------------------------------------------
" Run Language Extensions
source $HOME/.config/nvim/languages.vim

" Sleep: ensure everything is ready to be configured and used
call system("execute sleep 0.2")

" -----------------------------------------------
" Run UX and Style extensions
source $HOME/.config/nvim/style.vim
source $HOME/.config/nvim/ux.vim
source $HOME/.config/nvim/modules/go/ux.vim

" CONFIGURE markdown plugin
lua require("headlines").setup()


" Create a single startup function to run after everything is loaded.
function! s:FinalStartup()
  " 1. Open NERDTree if no files were provided.
  if argc() == 0 && !exists("s:std_in")
    NERDTree
  endif

  " 2. Move cursor to the main window.
  wincmd p

  " 3. Force barbar.nvim to redraw. This is now safe because this entire
  "    function is deferred until after all plugins are fully loaded.
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
