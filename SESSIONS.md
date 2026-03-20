# Sessions Configuration

## Requirements (from user)
1. ✅ Remember sessions automatically by .git repository (not branch)
2. ✅ Save sessions automatically by .git repository
3. ✅ Open the same session independently of branch
4. ✅ If files not present or new session: use NERDTree + vim-startify
5. ✅ Use existing root discovery functions (radix.nvim)

## Configuration Files

### `lua/extensions/ux/sessions.lua`
Main session configuration that:
- Uses `radix.nvim` to detect git root directory
- Encodes git root path for session filename
- Configures `auto-session` plugin with:
  - `auto_restore_last_session = false` - prevents loading sessions from other projects
  - `cwd_change_handling = false` - prevents cross-repo session loading when changing directories
  - Sessions are stored per git repository root (not per branch)
- Manual session restore on `VimEnter` with error handling
- Sets `g:session_restored` flag to track if session was loaded

### `init.vim`
- Modified `s:FinalStartup()` to check `g:session_restored` before opening NERDTree
- NERDTree only opens if:
  - No files were provided as arguments
  - No session was restored
  - Not running in stdin mode

### `ux.vim`
- Removed conflicting `VimEnter` autocommand that was opening NERDTree prematurely
- Updated `AutoSessionFocus` augroup to set `g:session_restored = 1` on session restore
- Kept `EnsureNerdTreeAtRootAndFocusFile()` for post-session restoration setup

### `lua/extensions/infra/treesitter.lua`
- Disabled treesitter highlight for `vim` and `vimdoc` filetypes
- This fixes the "Invalid node type 'substitute'" error
- Uses vim regex highlighting for vim files instead (`additional_vim_regex_highlighting = true`)

## How It Works

### Startup Flow
1. **VimEnter** (early): `restore_session_for_git_repo()` is called
   - Gets git root using `radix.nvim`
   - Encodes git root path for session filename
   - If session file exists: sources it and sets `g:session_restored = true`
   - If no session: sets `g:session_restored = false`

2. **PlugLoaded** (after plugins): `s:FinalStartup()` is called
   - If `g:session_restored` exists: skips opening NERDTree (session already loaded buffers)
   - If `g:session_restored` doesn't exist: opens NERDTree at project root

3. **SessionLoadPost / AutoSessionRestorePost**: `EnsureNerdTreeAtRootAndFocusFile()` is called
   - Ensures NERDTree is open at project root
   - Focuses on the restored file/buffer
   - Reveals current file in NERDTree

### Shutdown Flow
1. **VimLeavePre**: Session is saved automatically by `auto-session`
   - NERDTree is closed before saving (`pre_save_cmds`)
   - Session is saved with git root as filename

## Session Isolation
- Each git repository has its own session file
- Branches within the same repository share the same session
- Sessions from different repositories never mix
- No fallback to "last session" from other projects

## Session Storage
Sessions are stored in: `~/.local/share/nvim/sessions/`
Filename format: encoded git root path (e.g., `%2Fhome%2Fuser%2Fproject.vim`)

## Troubleshooting

### Check if session was restored
```vim
:echo exists('g:session_restored')
```

### View session files
```bash
ls -la ~/.local/share/nvim/sessions/
```

### Delete a specific session
```bash
rm ~/.local/share/nvim/sessions/%2Fpath%2Fto%2Fproject.vim
```

### Force session save
```vim
:SaveSession
```

### Force session restore
```vim
:RestoreSession
```

### Check current git root
```vim
:lua print(require('radix').get_root_dir(vim.fn.getcwd()))
```

## Known Issues

### Treesitter vim parser error
**Error**: `Invalid node type "substitute"`

**Solution**: Treesitter highlight for vim/vimdoc is disabled. Vim regex highlighting is used instead.
This is handled automatically by `lua/extensions/infra/treesitter.lua`.

### Session not restoring
**Causes**:
1. Session file doesn't exist (new project)
2. Git root not detected (not a git repository)
3. Files provided as arguments to nvim

**Solution**: 
- Ensure project is a git repository
- Check session file exists in `~/.local/share/nvim/sessions/`
- Run `:SaveSession` before closing nvim

### NERDTree opens even with session restored
**Cause**: `g:session_restored` flag not set properly

**Solution**:
- Check `:messages` for session restore errors
- Verify session file is valid vim script
- Run `:echo exists('g:session_restored')` after startup
