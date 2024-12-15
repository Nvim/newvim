return {
	"Civitasv/cmake-tools.nvim",
	lazy = true,
	init = function()
		local loaded = false
		local function check()
			local cwd = vim.uv.cwd()
			if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
				require("lazy").load({ plugins = { "cmake-tools.nvim" } })
				loaded = true
			end
		end
		check()
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				if not loaded then
					check()
				end
			end,
		})
	end,
	opts = {
		cmake_regenerate_on_save = false,
		cmake_executor = { -- executor to use
			name = "overseer", -- name of the executor
			opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
			default_opts = { -- a list of default and possible values for executors
				quickfix = {
					show = "always", -- "always", "only_on_error"
					position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
					size = 10,
					encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
				overseer = {
					new_task_opts = {
						strategy = {
							"jobstart",
							-- direction = "horizontal",
							-- autos_croll = true,
							-- quit_on_exit = "success",
						},
					}, -- options to pass into the `overseer.new_task` command
					on_new_task = function(task)
						-- require("overseer").open({ enter = false, direction = "right" })
						require("overseer").open({ enter = false, direction = "right", on_output_quickfix = true })
					end, -- a function that gets overseer.Task when it is created, before calling `task:start`
				},
				terminal = {
					name = "Main Terminal",
					prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
					split_direction = "horizontal", -- "horizontal", "vertical"
					split_size = 11,

					-- Window handling
					single_terminal_per_instance = true, -- Single viewport, multiple windows
					single_terminal_per_tab = true, -- Single viewport per tab
					keep_terminal_static_location = true, -- Static location of the viewport if avialable
					auto_resize = true, -- Resize the terminal if it already exists

					-- Running Tasks
					start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
					focus = false, -- Focus on terminal when cmake task is launched.
					do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
				}, -- terminal executor uses the values in cmake_terminal
			},
		},
		cmake_runner = { -- runner to use
			name = "overseer", -- name of the runner
			opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
			default_opts = { -- a list of default and possible values for runners
				quickfix = {
					show = "always", -- "always", "only_on_error"
					position = "belowright", -- "bottom", "top"
					size = 10,
					encoding = "utf-8",
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
				overseer = {
					new_task_opts = {
						strategy = {
							"terminal",
							direction = "horizontal",
							autos_croll = true,
							quit_on_exit = "success",
						},
					}, -- options to pass into the `overseer.new_task` command
					on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
				},
				terminal = {
					name = "Main Terminal",
					prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
					split_direction = "horizontal", -- "horizontal", "vertical"
					split_size = 11,

					-- Window handling
					single_terminal_per_instance = true, -- Single viewport, multiple windows
					single_terminal_per_tab = true, -- Single viewport per tab
					keep_terminal_static_location = true, -- Static location of the viewport if avialable
					auto_resize = true, -- Resize the terminal if it already exists

					-- Running Tasks
					start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
					focus = false, -- Focus on terminal when cmake task is launched.
					do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
				},
			},
			cmake_dap_configuration = { -- debug settings for cmake
				name = "CMake Debugger",
				type = "lldb",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = true,
				console = "integratedTerminal",
			},
		},
	},
	-- mappings:
	keys = {
		-- Other actions:
		{ "<leader>cd", ":CMakeDebug<cr>", { desc = "CMake Debug" } },
		{ "<leader>ct", ":CMakeRunTest<cr>", { desc = "CMake Run test" } },
		{ "<leader>cc", ":CMakeClean<cr>", { desc = "CMake Clean" } },

		-- Build and run:
		{ "<leader>cP", ":CMakeSelectConfigurePreset<cr>", { desc = "CMake Select configure preset" } },
		{ "<leader>cp", ":CMakeSelectBuildPreset<cr>", { desc = "CMake Select build preset" } },
		{ "<leader>cB", ":CMakeSelectBuildTarget<cr>", { desc = "CMake Select target to build" } },
		{ "<leader>cx", ":CMakeQuickRun<cr>", { desc = "CMake Run" } },
		{ "<leader>cb", ":CMakeQuickBuild<cr>", { desc = "CMake Build Target" } },

		-- Misc:
		{ "<leader>cs", ":CMakeStopRunner<cr>:CMakeCloseRunner<cr>", { desc = "CMake Stop runner" } },
		{ "<leader>cS", ":CMakeStopExecutor<cr>:CMakeCloseExecutor<cr>", { desc = "CMake Stop executor" } },
		{ "<leader>cf", ":CMakeShowTargetFiles<cr>", { desc = "CMake Show Target Files" } },
		{ "<leader>ca", ":CMakeLaunchArgs<cr>", { desc = "CMake Set launch args" } },
	},
}
