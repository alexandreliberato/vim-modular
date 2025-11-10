-- [[ Configure buffers using Lua Line ]] 

-- Bufferline plugin configuration
vim.opt.termguicolors = true


-- Bufferline 
local bufferline = require('bufferline')

require("bufferline").setup{
    options = {
        --style_preset = bufferline.style_preset.minimal,
        diagnostics = "coc",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
                        {
                            filetype = "nerdtree",
                            text = "File Explorer",
                            text_align = "center",
--                            highlight = "Directory",
                            separator = true
                        }
                    },
        },
}




-- Unique names

-- Sidebar offsets

-- Underline indicator

-- Alternate styling
