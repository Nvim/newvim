return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonInstallAll" },
	opts = {
		-- ensure_installed = require("utils.server_list").others,
		ensure_installed = {},
	},
	config = function(_, opts)
		require("mason").setup(opts)
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
		end, {})

		vim.g.mason_binaries_list = opts.ensure_installed
	end,
}
