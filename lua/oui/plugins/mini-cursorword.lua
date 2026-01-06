return {
  {
    'nvim-mini/mini.cursorword',
    version = false,
    config = function()
      require("mini.cursorword").setup()
      -- vim.api.nvim_set_hl(0, 'MiniCursorword', { })
      -- vim.api.nvim_set_hl(0, 'MiniCursorword', { underline = true, })
    end
  },
}
