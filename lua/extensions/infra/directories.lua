require("radix").setup({
    -- if false cwd will be left unchanged if no directory is found
    -- otherwise it uses the head of the starting path
    fallback = true,

    -- callback for when a directory was successfully found
    -- path contains the directory
    on_success = function (path) end,

    -- glob patterns to query
    patterns = {
        ".git",
    },

    -- if false a notification will be shown when changing the cwd
    silent = true
})
