" general
let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_gopls_complete_unimported = 1

" colors
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" same word highlight
let g:go_auto_sameids = 1

" >> automations for GO
"=======================

" > run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" auto import dependencies
let g:go_fmt_command = "goimports"


"
" Build & Run
"

" Build
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" Test
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" Run
autocmd FileType go nmap <leader>r  <Plug>(go-run)

"
" Debug
"

" Set Breakpoint
nnoremap <F4> :GoDebugBreakpoint<CR>
" Start
nnoremap <F5> :GoDebugStart<CR>
" Continue
nnoremap <F6> :GoDebugContinue<CR>
" Step
nnoremap <F7> :GoDebugStep<CR>
" Step out
nnoremap <F8> :GoDebugStepOut<CR>
" Next
nnoremap <F9> :GoDebugNext<CR>

"
" Navigation
"

" GoDef go to definition
" GoPop go back from definition
