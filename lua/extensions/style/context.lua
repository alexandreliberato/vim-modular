

--Use the highlight groups TreesitterContextBottom and/or TreesitterContextLineNumberBottom to change the highlight of the last line of the context window. By default it links to NONE. However, you can use this to create a border by applying an underline highlight, e.g, for an underline across the screen:
local function SetTreeSitterHighlights()
    -- underline bottom separator (use sp for special color and underline=true for nvim_set_hl)
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = 'Grey' })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = 'Grey' })

    -- main context background/foreground (override colorscheme default which was green)
    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#4d4dff', fg = '#e0e0e0' })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { bg = '#4d4dff', fg = '#e0e0e0' })
end

-- Reapply after any colorscheme change (colorscheme overrides highlights)
vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('TreesitterContextRecolor', { clear = true }),
    callback = function() SetTreeSitterHighlights() end,
})

-- Apply once on startup (schedule so it's after initial colorscheme in style.vim)
vim.schedule(SetTreeSitterHighlights)

