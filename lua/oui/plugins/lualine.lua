local config = function()
  local lualine = require("lualine")

  -- configure lualine with modified theme
  lualine.setup({
    options = {

      theme = "nord",
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = ""},

    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "" },
      lualine_x = { "overseer" },
      lualine_y = { "diagnostics", "filetype" },
      lualine_z = { "buffers" },
    },
  })
end

local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- TODO: theme it
  config = config,
}

return M
