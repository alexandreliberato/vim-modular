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


" -----------------------------------------------
" Run Language Extensions
source $HOME/.config/nvim/languages.vim

" -----------------------------------------------
" Run UX and Style extensions
source $HOME/.config/nvim/style.vim
source $HOME/.config/nvim/ux.vim
source $HOME/.config/nvim/modules/go/ux.vim




" =====================================
" Colorscheme: initialize
" =====================================
"silent call Dark()

autocmd VimEnter * wincmd p
