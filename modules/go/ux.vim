" Set tabs and indents (for go) TODO how it knows that its just for GO?
"set ts=8
"set shiftwidth=8
"set ai sw=8

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
" Start
" Continue
" Next
" Step
" Step out
"

"
" Navigation
"

" GoDef go to definition
" GoPop go back from definition
