-- =========================================================================
-- SESSIONS: UX

-- Recommended sessionoptions for auto-session so that buffers, windows,
-- folds, terminals, etc. are correctly restored.
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Always keep Neovim's cwd at the project (git) root, based on the
-- *current buffer's* directory. This plays nicer with auto-session and
-- NERDTree than relying only on the shell cwd.

local function set_cwd_to_git_root()
  local ok, radix = pcall(require, "radix")
  if not ok then
    return
  end

  -- Skip special buffers like NERDTree
  local ft = vim.bo.filetype
  local bufname = vim.api.nvim_buf_get_name(0)
  if ft == "nerdtree" or bufname:match("NERD_tree_") then
    return
  end

  local base
  if bufname ~= "" then
    base = vim.fn.fnamemodify(bufname, ":p:h")
  else
    base = vim.fn.getcwd()
  end

  local root = radix.get_root_dir(base)

  if root and root ~= "" and root ~= vim.fn.getcwd() then
    -- Set Neovim's working directory to the git root
    vim.cmd("cd " .. vim.fn.fnameescape(root))

    -- If NERDTree is open, update its root to the current cwd so
    -- the tree always reflects the project root instead of some
    -- previously saved directory from a session.
    pcall(vim.cmd, "silent! NERDTreeCWD")
  end
end

-- Encode a path the same way auto-session does for its filenames.
-- Example: "/home/user/project" -> "%2Fhome%2Fuser%2Fproject.vim"
local function encode_session_name(path)
  -- First escape '%', then encode '/' and '.'.
  local encoded = path:gsub("%%", "%%25")
  encoded = encoded:gsub("/", "%%2F")
  encoded = encoded:gsub("%.", "%%2E")
  return encoded
end

-- Manually restore the session that exactly matches the current cwd.
-- This prevents auto-session from loading some "last" session from
-- a completely different project.
local function restore_session_for_cwd()
  local cwd = vim.fn.getcwd()
  if cwd == "" then
    return
  end

  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  local session_file = session_dir .. "/" .. encode_session_name(cwd) .. ".vim"

  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(session_file))
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- 1) Normalize cwd to git root (if any)
    set_cwd_to_git_root()
    -- 2) Restore ONLY the session that matches this cwd
    restore_session_for_cwd()
  end,
})

-- Sessions + git / auto-session
-- This enables automatic save/restore and also handles cwd changes so that
-- sessions are tied to the project (git) root.
require("auto-session").setup({
  -- Saving / restoring
  enabled = true,
  auto_save = true,
  -- We restore sessions manually (see restore_session_for_cwd above)
  -- so that only the current project (cwd) is restored.
  auto_restore = false,
  auto_create = true,
  -- Restore sessions per-project (per cwd/git root) only; do NOT
  -- fall back to the last unrelated session from another project.
  auto_restore_last_session = false,

  -- Track directory changes and keep sessions in sync.
  cwd_change_handling = true,

  pre_cwd_changed_cmds = {
    "tabdo NERDTreeClose", -- Close NERDTree before saving session
  },

  -- After auto-session changes cwd, normalize to the git root again and
  -- then refresh the statusline.
  post_cwd_changed_cmds = {
    function()
      set_cwd_to_git_root()
    end,
    function()
      require("lualine").refresh() -- refresh the lualine status line _after_ the cwd changes
    end,
  },
})


