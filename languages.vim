" ===================================================================================
" LSP: Languages Servers Configurations
"

" ----------------------------------------------------------
" COC
"

" TODO: improve design
" Define Coc extensions to auto-install (avoids early coc#util#install errors)
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-git',
	\ 'coc-java',
	\ 'coc-kotlin',
	\ 'coc-pyright',
	\ 'coc-yaml',
	\ 'coc-go',
	\ 'coc-sql',
	\ 'coc-sumneko-lua'
	\ ]


" -----------------------------------------------------------
"  NVIM LSP: Native Language Server Support
"

lua pcall(require,'elixir.nvim_lsp')
