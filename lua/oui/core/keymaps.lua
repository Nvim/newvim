vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local map = vim.keymap.set

-- Neovide
if vim.g.neovide then
  -- Copy-paste:
  map("v", "<D-c>", '"+y')         -- Copy
  map("n", "<D-v>", '"+P')         -- Paste (normal)
  map("v", "<D-v>", '"+P')         -- Paste (visual)
  map("i", "<D-v>", '<ESC>l"+Pli') -- Paste (insert)
  map("c", "<D-v>", "<C-R>+")      -- Paste (command)

  -- Scale:
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  map("n", "<C-=>", function()
    change_scale_factor(1.125)
  end)
  map("n", "<C-->", function()
    change_scale_factor(1 / 1.125)
  end)
end

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map("n", "<right>", ":vertical resize +2<cr>")
map("n", "<left>", ":vertical resize -2<cr>")
map("n", "<down>", ":resize +2<cr>")
map("n", "<up>", ":resize -2<cr>")

-- navigate in insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })


map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment line" }
)

map("n", "<leader>nx", ":cd $NOTES_DIR<cr>", { desc = "Go to notes dir" })
map("n", "<leader>DD", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete current file" })
