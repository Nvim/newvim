local filepath = vim.fn.expand('%:p')

-- Get ~/Documents as an absolute path
local documents_dir = vim.fn.expand('~') .. '/Documents/Nextcloud/Obsidian' .. '/'

-- Check if the file is inside ~/Documents
if vim.startswith(filepath, documents_dir) then
else
end

vim.opt_local.wrap = true
vim.opt_local.spell = true
