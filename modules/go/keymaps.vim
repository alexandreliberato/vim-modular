" =================================================================
" GO KEYMAPS
"

"
" General
"

" Rename 
autocmd FileType go nmap <leader>gr <Plug>(go-rename)


"
" Testing
"

" Test
autocmd FileType go nmap <leader>gt  <Plug>(go-test)
"
" Test Nearest Function
autocmd FileType go nmap <leader>gtf  <Plug>(go-test-func)



"
" Build & Run
"

" (off) Build
autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>

" Run App
autocmd FileType go nmap <leader>gra  <Plug>(go-run)
