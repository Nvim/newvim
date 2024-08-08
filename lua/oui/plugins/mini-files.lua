return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    local MiniFiles = require("mini.files")
    MiniFiles.setup({})
    local minifiles_toggle = function(...)
      if not MiniFiles.close() then
        MiniFiles.open(...)
      end
    end
    vim.keymap.set("n", "<leader>e", function()
      minifiles_toggle()
    end, { desc = "Toggle Files" })
  end,
}
