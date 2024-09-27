-- TODO: read the docs to find a way to set names instead of 'prefix'
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    spec = {
      mode = { "n" },
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>g", group = "Git" },
      { "<leader>n", group = "Obsidian" },
      { "<leader>t", group = "Tailwind/Tabs" },
      { "<leader>s", group = "Splits" },
      { "<leader>d", group = "DAP" },
      { "<leader>o", group = "Overseer" },
    },
  },
}
