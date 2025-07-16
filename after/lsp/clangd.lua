local M = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
		"--offset-encoding=utf-16",
	},
	root_dir = vim.fs.root(
		vim.fs.joinpath(vim.env.PWD, "compile_commands.json"),
		{ ".clangd", ".clang-format", ".clang-tidy" }
	) or vim.fn.getcwd(),
	on_attach = function(_, bufnr)
		vim.keymap.set("n", "<leader>ls", function()
			vim.cmd("ClangdSwitchSourceHeader")
		end, { buffer = bufnr, remap = false, silent = true, desc = "ClangdSwitchSourceHeader" })
	end,
}

return M
