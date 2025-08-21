return {
	"saghen/blink.cmp",
	dependencies = {
    "rafamadriz/friendly-snippets",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	event = "InsertEnter",

	-- use a release tag to download pre-built binaries
	version = "v1.*",

	opts = {
    snippets = { preset = 'luasnip' },
		keymap = {
			preset = "default",
			["<C-k>"] = {},
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		cmdline = {
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
						-- enable for inputs as well, with:
						-- or vim.fn.getcmdtype() == '@'
					end,
				},
			},
		},

		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			list = {
				max_items = 20,
				selection = { preselect = true, auto_insert = true },
			},

			menu = {
				border = "single",
				scrollbar = false,
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind", "source_name", gap = 1 },
					},
				},
			},
			documentation = {
				window = { border = "single" },
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
		},
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
