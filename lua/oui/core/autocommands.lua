vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.vs", "*.fs", "*.vert", "*.frag", "*.shader", "*.glsl", "*.fsh", "*.vsh" },
	callback = function()
		vim.bo.filetype = "glsl"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "glsl",
  callback = function()
    local opt = vim.opt_local
    opt.tabstop = 4
    opt.softtabstop = 4
    opt.shiftwidth = 4
  end,
})
