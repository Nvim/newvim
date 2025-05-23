local codeium = {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	config = function()
		local s = vim.keymap.set
		local opts = { expr = true, silent = true }

		vim.g.codeium_disable_bindings = 1 --disables defaults
		vim.g.codeium_enabled = false

		s("i", "<S-Tab>", function()
			return vim.fn["codeium#Accept"]()
		end, opts)
		s("i", "<c-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, opts)
		s("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, opts)
		s("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, opts)

		s("n", "<leader><cx>", function()
			vim.g.codeium_enabled = false
		end, opts)
		s("n", "<leader><ce>", function()
			vim.g.codeium_enabled = true
		end, opts)
	end,
}

-- return codeium
return {}
