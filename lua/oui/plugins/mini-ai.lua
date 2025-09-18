return {
	"nvim-mini/mini.ai",
	event = "VeryLazy",
	opts = function()
		local ai = require("mini.ai")
		return {
			n_lines = 100,
			custom_textobjects = {
        -- Code:
				o = ai.gen_spec.treesitter({ -- Blocks
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- Class
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- Tags

        -- Functions:
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- Function
				u = ai.gen_spec.function_call(), -- u for "Usage"
				U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name

        -- Assignments:
        g = ai.gen_spec.treesitter({a = "@assignment.outer", i = "@assignment.inner"}), -- Assignment
        r = ai.gen_spec.treesitter({a = "@assignment.rhs", i = "@assignment.rhs"}), -- Assignment rhs
        R = ai.gen_spec.treesitter({a = "@assignment.lhs", i = "@assignment.lhs"}), -- Assignment lhs

        -- Misc:
        G = ai.gen_spec.treesitter({a = "@comment.outer", i = "@comment.inner"}), -- Comment
				d = { "%f[%d]%d+" }, -- digits
				e = { -- Word with case
					{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
					"^().*()$",
				},
			},
		}
	end,
	config = function(_, opts)
		require("mini.ai").setup(opts)
	end,
}
