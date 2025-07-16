local M = {
  "mrjones2014/smart-splits.nvim",
  opts = {
      at_edge = 'stop',
      log_level = 'error',
  },
  config = function(opts)
    local ss = require('smart-splits')
    ss.setup(opts)
    -- vim.keymap.set('n', '<A-h>', ss.resize_left)
    -- vim.keymap.set('n', '<A-j>', ss.resize_down)
    -- vim.keymap.set('n', '<A-k>', ss.resize_up)
    -- vim.keymap.set('n', '<A-l>', ss.resize_right)
    -- moving between splits
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left)
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down)
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up)
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right)
    vim.keymap.set('n', '<C-\\>', ss.move_cursor_previous)
  end

}

return {}
