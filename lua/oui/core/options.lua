local opt = vim.opt

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font"
  vim.opt.linespace = 1
  vim.g.neovide_padding_top = 5
  vim.g.neovide_opacity = 1.0
  vim.g.neovime_cursor_animation_length = 0.06
  vim.g.neovime_cursor_trail_size = 0.3
end

opt.exrc = true
-- for markdown:
-- opt.conceallevel = 2
--vim.g.filetype.plugin.on = 1

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
vim.opt.nu = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = false -- highlight search results
opt.incsearch = true -- moves you to search result as you type
opt.inccommand = "split" -- opens new window for '%s'

-- cursor line
opt.cursorline = true -- highlight the current cursor line
vim.opt.scrolloff = 8 -- prevent scrolling to  the last line

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- virtualedit for visual block --
opt.virtualedit = "block"

-- diagnostics symbols
vim.diagnostic.config({
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
