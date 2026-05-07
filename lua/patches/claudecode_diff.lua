-- Patch: close NERDTree before claudecode opens a diff.
--
-- Why: claudecode's `find_main_editor_window` does not recognize the classic
-- nerdtree filetype as a sidebar to skip, so it can pick the NERDTree window
-- as the "main editor" and split inside it — producing a tiny, broken layout.
-- Closing NERDTree first lets the diff take the full code area.

local ok, diff = pcall(require, "claudecode.diff")
if not ok then
  return
end

local original = diff.open_diff_blocking
diff.open_diff_blocking = function(...)
  pcall(function()
    if vim.fn.exists(":NERDTreeClose") == 2 then
      vim.cmd("silent! NERDTreeClose")
    end
  end)
  return original(...)
end
