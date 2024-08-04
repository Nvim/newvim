vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
-- keymap.set("n", "<ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- switch between windows
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- find and replace:
keymap.set("n", "<leader>rr", ":%s/<<C-r><C-w>//g<Left><Left>")
keymap.set("n", "<right>", ":vertical resize +2<cr>")
keymap.set("n", "<left>", ":vertical resize -2<cr>")
keymap.set("n", "<down>", ":resize +2<cr>")
keymap.set("n", "<up>", ":resize -2<cr>")

-- big dinguerie: bouge les lignes selectionnees avec shift+j et k
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

--ctrl+d et u pour half page jumps
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page down" })

-- navigate in insert mode
keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Telescope --
keymap.set(
  "n",
  "<leader>ff",
  "<cmd>Telescope find_files theme=ivy layout_config={height=0.4} <cr>",
  { desc = "Find files" }
)
keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find string in buffer" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
keymap.set("n", "<leader>fn", "<cmd>Telescope man_pages<cr>", { desc = "Marks" })
keymap.set(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>",
  { desc = "Find hidden files" }
)

-- NeoTree --
keymap.set("n", "<leader>E", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })

--[[ Comment ]]
keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment line" })

keymap.set(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment line" }
)
