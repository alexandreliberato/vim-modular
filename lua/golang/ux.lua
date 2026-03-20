-- Go to write-only references (assignments) using gopls + Telescope
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.keymap.set('n', '<leader>gw', function()
      -- 1. Find gopls client
      local clients = vim.lsp.get_active_clients({ name = "gopls" })
      if #clients == 0 then
        vim.notify("gopls not running", vim.log.levels.WARN)
        return
      end

      -- 2. Get word under cursor
      local word = vim.fn.expand("<cword>")
      if word == "" then
        vim.notify("No identifier under cursor", vim.log.levels.WARN)
        return
      end

      -- 3. Open Telescope references with auto-filter for assignments
      require('telescope.builtin').lsp_references({
        -- Auto-apply filter for assignment operators
        default_text = "=",  -- Pre-fill search with "="
        layout_strategy = "vertical",
        layout_config = {
          prompt_position = "top",
          height = 0.4,
        },
        -- Optional: Highlight only lines with assignments
        entry_maker = function(entry)
          -- Keep original entry but note if it's likely a write
          local is_write = entry.text:match("[^%w_]%=([^=]|$)") or entry.text:match(":=")
          return {
            value = entry,
            display = is_write and ("→ " .. entry.display) or entry.display,
            ordinal = entry.ordinal,
          }
        end
      })
    end, { buffer = true, silent = true })
  end
})
