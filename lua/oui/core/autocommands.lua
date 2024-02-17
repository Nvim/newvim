vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = { "*.vs", "*.fs", "*.vert", "*.frag", "*.shader" }, command = [[set ft=glsl]] }
)
