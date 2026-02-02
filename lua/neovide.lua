local map = vim.keymap.set

-- Copy-paste:
map("v", "<D-c>", '"+y')           -- Copy
map("n", "<D-v>", '"+P')           -- Paste (normal)
map("v", "<D-v>", '"+P')           -- Paste (visual)
map("i", "<D-v>", '<ESC>l"+Pli')   -- Paste (insert)
map("c", "<D-v>", "<C-R>+")        -- Paste (command)

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

vim.o.guifont = "JetBrainsMono Nerd Font"
vim.opt.linespace = 1
vim.g.neovide_padding_top = 5
vim.g.neovide_opacity = 1.0
vim.g.neovide_normal_opacity = 0.86
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_trail_size = 0.3
