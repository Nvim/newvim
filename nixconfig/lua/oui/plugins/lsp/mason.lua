local get_pkg_path = function(pkg, path, opts)
	pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
	local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
	opts = opts or {}
	opts.warn = opts.warn == nil and true or opts.warn
	path = path or ""
	local ret = root .. "/packages/" .. pkg .. "/" .. path
	---@diagnostic disable-next-line: empty-block
	if opts.warn and not vim.loop.fs_stat(ret) then
		-- TODO: do something
	end
	return ret
end
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
