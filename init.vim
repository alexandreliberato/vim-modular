call plug#begin('~/.local/share/nvim/plugged')
source $HOME/.config/nvim/infra.vim
source $HOME/.config/nvim/ux.vim
source $HOME/.config/nvim/modules/java.vim
source $HOME/.config/nvim/modules/go/init.vim
source $HOME/.config/nvim/modules/go/ux.vim
call plug#end()

" CONFIGURE theme monokai
colorscheme monokai

function! Light()
    echom "set bg=light"
    set bg=light
    colorscheme off
    set list
endfunction

function! Dark()
    echom "set bg=dark"
    set bg=dark
    colorscheme monokai
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
nnoremap <leader>c :call ToggleLightDark()<CR>


" =====================================
" Init
" =====================================
silent call Dark()
autocmd VimEnter * wincmd p
