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

" Helper: jump cursor to the enclosing Go function/method name using treesitter.
" Returns true on success, false if no enclosing function was found.
lua << EOF
function _G.__goto_enclosing_go_func()
  local node = vim.treesitter.get_node()
  while node do
    local t = node:type()
    if t == 'function_declaration' or t == 'method_declaration' then
      local name = node:field('name')[1]
      if name then
        local r, c = name:start()
        vim.api.nvim_win_set_cursor(0, { r + 1, c })
      end
      return true
    end
    node = node:parent()
  end
  return false
end
EOF

" Go references -> Telescope (async safe)
function! s:GoRefsTelescope()
  let l:cur_word = expand('<cword>')

  " If cursor is not on an identifier (e.g. empty line, whitespace, punctuation),
  " jump to the enclosing function's name so references resolve to that function.
  if l:cur_word == '' || l:cur_word !~ '^\w\+$'
    if !luaeval('_G.__goto_enclosing_go_func()')
      echo "No enclosing function found"
      return
    endif
  endif

  " Capture invocation location to filter the declaration itself and its sibling test file.
  let l:invoke_file = expand('%:p')
  let l:invoke_line = line('.')

  silent GoReferrers
  " Delay to allow vim-go/gopls to fill the location list, then filter and show Telescope.
  call timer_start(180, { -> s:FinishGoRefs(l:invoke_file, l:invoke_line) })
endfunction

function! s:FinishGoRefs(file, line) abort
  lclose
  call s:FilterGoRefs(a:file, a:line)
  Telescope loclist
endfunction

" Drop the function's own declaration (same file+line as invocation) and any
" entries from the sibling test file (foo.go <-> foo_test.go in same dir).
function! s:FilterGoRefs(file, line) abort
  let l:dir = fnamemodify(a:file, ':h')
  let l:base = fnamemodify(a:file, ':t:r')
  if l:base =~# '_test$'
    let l:sibling = l:dir . '/' . substitute(l:base, '_test$', '', '') . '.go'
  else
    let l:sibling = l:dir . '/' . l:base . '_test.go'
  endif

  let l:filtered = []
  for l:item in getloclist(0)
    let l:path = l:item.bufnr > 0 ? fnamemodify(bufname(l:item.bufnr), ':p') : ''
    if l:path ==# l:sibling
      continue
    endif
    if l:path ==# a:file && l:item.lnum == a:line
      continue
    endif
    call add(l:filtered, l:item)
  endfor

  call setloclist(0, l:filtered, 'r')
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

