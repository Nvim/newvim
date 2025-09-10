return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerOpen",
		"OverseerClose",
		"OverseerToggle",
		"OverseerSaveBundle",
		"OverseerLoadBundle",
		"OverseerDeleteBundle",
		"OverseerRunCmd",
		"OverseerRun",
		"OverseerInfo",
		"OverseerBuild",
		"OverseerQuickAction",
		"OverseerTaskAction",
		"OverseerClearCache",
	},
	opts = {
		dap = false,
		task_list = {
			bindings = {
        ["R"] = "<CMD>OverseerQuickAction restart<CR>"
			},
		},
		form = {
			win_opts = {
				winblend = 0,
			},
		},
		confirm = {
			win_opts = {
				winblend = 0,
			},
		},
		task_win = {
			win_opts = {
				winblend = 0,
			},
		},
		-- Templates:
		templates = {
			"builtin",
			"user.run_script",
		},
		component_aliases = {
			default_neotest = {
				"on_output_summarize",
				"on_exit_set_status",
				"on_complete_notify",
				"on_complete_dispose",
			},
		},
	},
  -- stylua: ignore
  keys = {
    { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
    { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
    { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
    { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
    { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
    { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
    { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
    { "<leader>or", "<cmd>OverseerRestartLast<cr>",  desc = "Rerun last action" },
  },

	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		-- Extend default Makefile task to output in quickfix.
		-- Uses `module` to match, since the make builtin is in namespace overseer.template.make
		overseer.add_template_hook({ module = "^make$" }, function(task_defn, util)
			util.add_component(task_defn, { "on_output_quickfix", open = true })
		end)

		-- Autocmd to restart last task
		vim.api.nvim_create_user_command("OverseerRestartLast", function()
			local tasks = overseer.list_tasks({ recent_first = true })
			if vim.tbl_isempty(tasks) then
				vim.notify("No tasks found", vim.log.levels.WARN)
			else
				overseer.run_action(tasks[1], "restart")
			end
		end, {})
	end,
}
