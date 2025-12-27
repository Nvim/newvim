vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Neovide
if vim.g.neovide then
	-- Copy-paste:
	keymap.set("v", "<D-c>", '"+y') -- Copy
	keymap.set("n", "<D-v>", '"+P') -- Paste (normal)
	keymap.set("v", "<D-v>", '"+P') -- Paste (visual)
	keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste (insert)
	keymap.set("c", "<D-v>", "<C-R>+") -- Paste (command)

	-- Scale:
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	keymap.set("n", "<C-=>", function()
		change_scale_factor(1.125)
	end)
	keymap.set("n", "<C-->", function()
		change_scale_factor(1/1.125)
	end)
end

-- clear search highlights
-- keymap.set("n", "<ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<right>", ":vertical resize +2<cr>")
keymap.set("n", "<left>", ":vertical resize -2<cr>")
keymap.set("n", "<down>", ":resize +2<cr>")
keymap.set("n", "<up>", ":resize -2<cr>")

-- navigate in insert mode
keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })


keymap.set(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Comment line" }
)

keymap.set("n", "<leader>nx", ":cd $NOTES_DIR<cr>", { desc = "Go to notes dir" })
keymap.set("n", "<leader>DD", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete current file" })
