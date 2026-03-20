" ===================================================================================
" Golang UX 

" ------------------------------------------
" COC-GO
"

" Organize import when a .go file is writen
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Navigate Diagnostics/Problems/Errors.
" ]p - next problem
" [p - previous problem
nmap <silent> [p <Plug>(coc-diagnostic-prev)
nmap <silent> ]p <Plug>(coc-diagnostic-next)


" -------------------------------------------
" VIM-GO

" 
let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

let g:go_test_show_name = 1

let g:go_autodetect_gopath = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golangci-lint']
let g:go_metalinter_enabled = ['vet', 'golangci-lint']
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave_enabled = ['vet','revive','errcheck','staticcheck','unused','varcheck']

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
"let g:go_auto_sameids = 1

" vim-go: use just one list of errors: quickfix
"let g:go_list_type = "quickfix"

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
" Debug
"

" UI
nnoremap <F1> :lua require("dapui").open()
nnoremap <F2> :lua require("dapui").close()
nnoremap <F3> :lua require("dapui").toggle()

" Set Breakpoint
nnoremap <F4> :DapToggleBreakpoint<CR>
" Start
nnoremap <F5> :DapNew<CR>
" Continue
nnoremap <F6> :DapContinue<CR>
" Step over
nnoremap <F7> :DapStepOver<CR>
" Step into
nnoremap <F8> :DapStepInto<CR>
" Start test nearest debug
nnoremap <F9> :lua require('dap-go').debug_test()<CR>

"
" Navigation
"

" Go references -> Telescope (async safe)
function! s:GoRefsTelescope()
  silent GoReferrers
  " Delay to allow vim-go/gopls to fill the location list
  " After vim-go populates the location list it opens a loclist window.
  " We schedule a small delay, close that window, then show Telescope's loclist picker.
  call timer_start(180, { -> execute('lclose | Telescope loclist') })
endfunction

" Referrers --- (start)

" go to references
autocmd FileType go nnoremap <silent><buffer> <leader>r :call <SID>GoRefsTelescope()<CR>

" (end) ---


" Go implements -> Telescope (async safe)
function! s:GoImplTelescope()
  silent GoImplements
  " Delay to allow vim-go/gopls to fill the location list
  " After vim-go populates the location list it opens a loclist window.
  " We schedule a small delay, close that window, then show Telescope's loclist picker.
  call timer_start(180, { -> execute('lclose | Telescope loclist') })
endfunction

autocmd FileType go nnoremap <silent><buffer> <leader>i :call <SID>GoImplTelescope()<CR>

