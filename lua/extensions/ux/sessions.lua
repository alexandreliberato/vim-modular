-- =========================================================================
-- SESSIONS: UX

-- Sessions + git
require("auto-session").setup({
    opts = {
      cwd_change_handling = true,

      pre_cwd_changed_cmds = {
        "tabdo NERDTreeClose", -- Close NERDTree before saving session
      },

      post_cwd_changed_cmds = {
        function()
          require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
        end,
      },
    }
})


