return {
	"luckasRanarison/tailwind-tools.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	cmd = { "TailwindConcealToggle", "TailwindColorToggle" },
	opts = {}, -- your configuration
	config = function()
		local set = vim.keymap.set

		set("n", "<leader>tt", "<cmd>TailwindConcealToggle<CR>", { desc = "Tailwind Conceal" })
		set("n", "<leader>tc", "<cmd>TailwindColorToggle<CR>", { desc = "Tailwind Colors" })
		require("tailwind-tools").setup({})
	end,
}
