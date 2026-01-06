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

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true, }),
  callback = function()
    vim.o.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.o.cursorline = false
  end,
})
