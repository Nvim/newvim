return {
	"saghen/blink.cmp",
	-- dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" }, "rafamadriz/friendly-snippets" },
  dependencies = "rafamadriz/friendly-snippets",
	event = "InsertEnter",

	-- use a release tag to download pre-built binaries
	version = "v0.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- "default" keymap
		--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		--   ['<C-e>'] = { 'hide' },
		--   ['<C-y>'] = { 'select_and_accept' },
		--
		--   ['<C-p>'] = { 'select_prev', 'fallback' },
		--   ['<C-n>'] = { 'select_next', 'fallback' },
		--
		--   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		--   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
		--
		--   ['<Tab>'] = { 'snippet_forward', 'fallback' },
		--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
		keymap = { preset = "default" },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			list = {
				max_items = 20,
				selection = {preselect = true, auto_insert = true },
			},

			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind", "source_name", gap = 1 },
					},
				},
			},

			ghost_text = {
				enabled = false,
			},
		},

		signature = {
			enabled = true,
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- providers = function(ctx)
			-- 	local node = vim.treesitter.get_node()
			-- 	if vim.bo.filetype == "lua" then
			-- 		return { "lsp", "path" }
			-- 	elseif node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
			-- 		return { "buffer" }
			-- 	else
			-- 		return { "lsp", "path", "snippets", "buffer" }
			-- 	end
			-- end,
			-- optionally disable cmdline completions
			-- cmdline = {},
		},
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
