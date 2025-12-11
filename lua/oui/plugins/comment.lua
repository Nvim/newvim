return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>/", function() require("Comment.api").toggle.linewise.current() end, desc = "Comment line" },
    { "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", desc = "Comment lines", mode="v" },
  }
}
