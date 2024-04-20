-- lspsaga
return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			code_action = {
				show_server_name = true,
			},
		})
	end,
}
