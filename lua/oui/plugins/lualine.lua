local config = function()
  local lualine = require("lualine")

  -- configure lualine with modified theme
  lualine.setup({
    options = {

      -- theme = "gruvbox",
      section_separators = { left = "", right = "" },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "" },
        lualine_x = { "" },
        lualine_y = { "diagnostics", "filetype" },
        lualine_z = { "buffers" },
      },
    },
  })
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- TODO: theme it
  config = config,
}
