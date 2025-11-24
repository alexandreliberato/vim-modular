-- ==============================================
-- PYTHON: Virtual Environments
--

local uv = require('uv')

-- Define a helper function that activates the virtual‑env
local function activate_venv()
  local venv_path = '/.venv'
  -- Only run the command if the folder exists
  if vim.fn.isdirectory(venv_path) == 1 then
    -- Call the uv module (or any command you need)
    uv.activate_venv(venv_path)
  end
end

-- Create the autocmd group (so you can clear/reload it easily)
vim.api.nvim_create_augroup('PythonVenv', { clear = true })

-- Register the autocmd for Python buffers
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'PythonVenv',
  pattern = '*.py',
  callback = activate_venv,
})
