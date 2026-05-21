-- =========================================================================
-- LINTERS (nvim-lint)

local ok, lint = pcall(require, 'lint')
if not ok then
  vim.notify('nvim-lint not available. Install with :PlugInstall', vim.log.levels.WARN)
  return
end

-- plantuml -syntax reads a diagram from stdin and prints:
--   ERROR
--   <line>      (1-indexed, relative to the diagram body — line 1 is the first
--                line AFTER @startuml)
--   <message>
--   Some diagram description contains errors
-- Exit code 200 on syntax error, 0 on success. Only the first error is reported.
lint.linters.plantuml = {
  cmd = 'plantuml',
  stdin = true,
  args = { '-syntax' },
  stream = 'stdout',
  ignore_exitcode = true,
  parser = function(output, bufnr)
    local diagnostics = {}
    local lines = vim.split(output or '', '\n', { plain = true })
    if lines[1] ~= 'ERROR' then
      return diagnostics
    end
    local reported = tonumber(lines[2])
    local message = lines[3] or 'Syntax error'
    if not reported then
      return diagnostics
    end

    -- Map the diagram-relative line back to a buffer line by finding the
    -- first @startuml. Good enough for single-diagram files (the common case).
    local startuml_lnum = 0
    local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for i, line in ipairs(buf_lines) do
      if line:match('^%s*@startuml') then
        startuml_lnum = i
        break
      end
    end

    local buffer_line = startuml_lnum + reported
    if buffer_line < 1 then buffer_line = 1 end
    if buffer_line > #buf_lines then buffer_line = #buf_lines end

    table.insert(diagnostics, {
      lnum = buffer_line - 1,
      col = 0,
      end_lnum = buffer_line - 1,
      end_col = #(buf_lines[buffer_line] or ''),
      severity = vim.diagnostic.severity.ERROR,
      source = 'plantuml',
      message = message,
    })
    return diagnostics
  end,
}

lint.linters_by_ft = vim.tbl_extend('force', lint.linters_by_ft or {}, {
  plantuml = { 'plantuml' },
})

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('nvim_lint_plantuml', { clear = true }),
  pattern = { '*.puml', '*.plantuml', '*.iuml', '*.pu' },
  callback = function()
    require('lint').try_lint()
  end,
})
