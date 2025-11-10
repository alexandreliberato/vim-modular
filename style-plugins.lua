vim.call('plug#begin', '~/.config/nvim/plugged') -- Specify the directory for installed plugins
    -- show icons in nerdtree 
    -- depends on UTF-8 being set, 'enconding=', nvim uses by default
    -- use 'ryanoasis/vim-devicons' -- TODO: it needs different fonts
    -- syntax highlight .hcl files

    vim.fn['Plug']('jvirtanen/vim-hcl')

    -- THEMES
    vim.fn['Plug']('iruzo/matrix-nvim')
vim.call('plug#end')
