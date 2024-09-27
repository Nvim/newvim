-- lspsaga
return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      ui = {
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
      code_action = {
        show_server_name = true,
      },
    })
  end,
}
