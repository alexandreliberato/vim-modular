-- =========================================================================
-- SESSIONS: UX
-- Requirements:
-- 1. Remember sessions automatically by .git repository (not branch)
-- 2. Save sessions automatically by .git repository
-- 3. Open the same session independently of branch
-- 4. If files not present or new session: use NERDTree + vim-startify
-- 5. Use existing root discovery functions

-- Recommended sessionoptions for auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"

-- Get git root directory using radix (already available in the project)
local function get_git_root()
  local ok, radix = pcall(require, "radix")
  if not ok then
    return vim.fn.getcwd()
  end

  local bufname = vim.api.nvim_buf_get_name(0)
  local base
  if bufname ~= "" then
    base = vim.fn.fnamemodify(bufname, ":p:h")
  else
    base = vim.fn.getcwd()
  end

  local root = radix.get_root_dir(base)
  if root and root ~= "" then
    return root
  end

  return vim.fn.getcwd()
end

-- Encode path for session filename
local function encode_session_name(path)
  local encoded = path:gsub("%%", "%%25")
  encoded = encoded:gsub("/", "%%2F")
  encoded = encoded:gsub("%.", "%%2E")
  return encoded
end

-- Manual session restore function
local function restore_session()
  -- Don't restore if files were provided as arguments
  if vim.fn.argc(-1) > 0 then
    return
  end

  -- Don't restore if running in stdin mode
  if vim.v.stdio_channel ~= nil then
    return
  end

  -- Get git root
  local git_root = get_git_root()
  if not git_root or git_root == "" then
    return
  end

  -- Encode session name
  local session_name = encode_session_name(git_root)
  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  local session_file = session_dir .. "/" .. session_name .. ".vim"

  -- Check if session file exists
  if vim.fn.filereadable(session_file) == 1 then
    local ok, err = pcall(function()
      vim.cmd("source " .. vim.fn.fnameescape(session_file))
    end)

    if ok then
      vim.g.session_restored = true
      vim.notify("Session restored for: " .. vim.fn.fnamemodify(git_root, ":t"), vim.log.levels.INFO)
    else
      vim.g.session_restored = false
      vim.notify("Failed to restore session: " .. tostring(err), vim.log.levels.WARN)
    end
  else
    vim.g.session_restored = false
  end
end

-- Configure auto-session ONLY if available (loaded after plug#end)
local function configure_auto_session()
  local auto_session_ok, auto_session = pcall(require, "auto-session")
  if not auto_session_ok then
    return
  end

  auto_session.setup({
    -- Enable auto creating, saving and restoring
    enabled = true,

    -- Auto save session on exit
    auto_save = true,

    -- Auto restore session on start (DISABLED - we handle manually)
    auto_restore = false,

    -- Auto create new session files
    auto_create = true,

    -- Auto delete empty sessions
    auto_delete_empty_sessions = true,

    -- Show notifications for auto restore
    show_auto_restore_notif = true,

    -- CRITICAL: Do NOT fall back to last session from other projects
    auto_restore_last_session = false,

    -- Disable cwd_change_handling to prevent cross-repo session loading
    cwd_change_handling = false,

    -- Session directory
    session_root_dir = vim.fn.stdpath("data") .. "/sessions",

    -- Close NERDTree before saving session
    pre_save_cmds = {
      "tabdo NERDTreeClose",
      function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end,
    },

    -- Bypass filter: always allow session creation/restoration for git repos
    bypass_session_save_file_filter = function()
      return true
    end,
  })
end

-- Schedule auto-session configuration for after plugins load
vim.schedule(function()
  configure_auto_session()
end)

-- Set session_restored flag after auto-session restores
local session_augroup = vim.api.nvim_create_augroup("AutoSessionGit", { clear = true })

-- Restore session on VimEnter (EARLY!)
vim.api.nvim_create_autocmd("VimEnter", {
  group = session_augroup,
  pattern = "*",
  callback = function()
    restore_session()
  end,
  nested = true,
})

-- ALSO restore immediately if VimEnter already passed
-- This handles the case where sessions.lua is loaded after VimEnter
if vim.v.vim_did_enter == 1 then
  restore_session()
end

vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = session_augroup,
  pattern = "*",
  callback = function()
    vim.g.session_restored = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = session_augroup,
  pattern = "AutoSessionRestorePost",
  callback = function()
    vim.g.session_restored = true
  end,
})
