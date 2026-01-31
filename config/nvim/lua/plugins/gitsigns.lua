return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- lazy-load when editing files
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },

    -- Optional but very nice
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
    },

    preview_config = {
      border = "rounded",
    },
  },
}
