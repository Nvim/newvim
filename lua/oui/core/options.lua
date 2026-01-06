local opt = vim.opt

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font"
  vim.opt.linespace = 1
  vim.g.neovide_padding_top = 5
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_normal_opacity = 0.86
  vim.g.neovide_cursor_animation_length = 0.06
  vim.g.neovide_cursor_trail_size = 0.3
end

opt.exrc = true
opt.relativenumber = true
opt.number = true
vim.opt.nu = true
opt.wrap = false
opt.cursorline = true
vim.opt.scrolloff = 8
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.swapfile = false
opt.virtualedit = "block"

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.inccommand = "split"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- diagnostics symbols
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})
