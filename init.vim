" LOAD ALL CONFIGURATIONS MODULES

" Install Vim Plug
" TODO: finalize logic
"if !filereadable(vimplug_exists)
"  if !executable(curl_exists)
"    echoerr "You have to install curl or first install vim-plug yourself!"
"    execute "q!"
"  endif
"  echo "Installing Vim-Plug..."
"  echo ""
"  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
"  let g:not_finish_vimplug = "yes"
"
"  autocmd VimEnter * PlugInstall
"endif

call plug#begin('~/.local/share/nvim/plugged')
    source $HOME/.config/nvim/infra.vim
    source $HOME/.config/nvim/ux-plugins.vim
    source $HOME/.config/nvim/modules/java.vim
    source $HOME/.config/nvim/modules/kotlin.vim
    source $HOME/.config/nvim/modules/python.vim
    source $HOME/.config/nvim/modules/elixir.vim
    source $HOME/.config/nvim/modules/plantuml.vim
    source $HOME/.config/nvim/modules/go/init.vim   
    luafile $HOME/.config/nvim/modules/lua.lua
call plug#end()

source $HOME/.config/nvim/style.vim
source $HOME/.config/nvim/ux.vim

" CONFIGURE markdown plugin
lua require("headlines").setup()


" =====================================
" Colorscheme: initialize
" =====================================
"silent call Dark()

autocmd VimEnter * wincmd p
