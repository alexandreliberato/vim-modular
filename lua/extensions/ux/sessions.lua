-- =========================================================================
-- SESSIONS: UX

-- Recommended sessionoptions for auto-session so that buffers, windows,
-- folds, terminals, etc. are correctly restored.
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"

-- Sessions + git / auto-session
-- This enables automatic save/restore and also handles cwd changes so that
-- sessions are tied to the project (git) root.
require("auto-session").setup({
  -- Saving / restoring
  enabled = true, -- enables/disables auto creating, saving and restoring
  auto_save = true, -- enables/disables auto saving session on exit
  auto_restore = true, -- enables/disables auto restoring session on start
  auto_create = true, -- enables/disables auto creating new session files. Can be a function that returns true if a new session file should be allowed
  auto_delete_empty_sessions = true,
  show_auto_restore_notif = true,
  -- Restore sessions per-project (per cwd/git root) only; if no session
  -- exists for current cwd, fall back to the last saved session.
  auto_restore_last_session = true, -- on startup, loads the last saved session if session for cwd does not exist
  -- Track directory changes and keep sessions in sync.
  cwd_change_handling = true, -- automatically save/restore sessions when changing directories
  pre_cwd_changed_cmds = {
    "tabdo NERDTreeClose", -- Close NERDTree before saving session
  },

  pre_save_cmds = {
    "tabdo NERDTreeClose", -- Close NERDTree before saving session
    function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end,
  },
})


