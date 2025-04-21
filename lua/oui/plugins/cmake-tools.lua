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
		cmake_dap_configuration = { -- debug settings for cmake
			name = "CMake",
			type = "lldb",
			request = "launch",
			stopOnEntry = true,
			runInTerminal = true,
			console = "integratedTerminal",
		},
		cmake_executor = { -- executor to use
			name = "quickfix", -- name of the executor
			opts = {
				show = "always", -- "always", "only_on_error"
				position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
				size = 10,
				encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
				auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
			},
		},
		cmake_runner = { -- runner to use
			name = "overseer", -- name of the runner
			opts = {
				new_task_opts = {
					strategy = {
						"terminal",
						direction = "horizontal",
						auto_scroll = true,
						quit_on_exit = "success",
					},
				}, -- options to pass into the `overseer.new_task` command
				-- on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
			}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
		},
	},
	-- mappings:
	keys = {
		-- Other actions:
		{ "<leader>cd", ":CMakeDebug<cr>", desc = "CMake Debug target" },
		{ "<leader>cD", ":CMakeDebugCurrentFile<cr>", desc = "CMake Debug current file" },
		{ "<leader>ct", ":CMakeRunTest<cr>", desc = "CMake Test" },
		{ "<leader>cc", ":CMakeClean<cr>", desc = "CMake Clean" },

		-- Build and run:
		{ "<leader>cP", ":CMakeSelectConfigurePreset<cr>", desc = "CMake Select configure preset" },
		{ "<leader>cp", ":CMakeSelectBuildPreset<cr>", desc = "CMake Select build preset" },

		{ "<leader>cO", ":CMakeSelectBuildTarget<cr>", desc = "CMake Select target to build" },
		{ "<leader>co", ":CMakeSelectLaunchTarget<cr>", desc = "CMake Select target to launch" },

		{ "<leader>cb", ":CMakeBuild<cr>", desc = "CMake Build (selected target)" },
		{ "<leader>cr", ":CMakeRun<cr>", desc = "CMake Run (selected target)" },

		{ "<leader>cQ", ":CMakeQuickBuild<cr>", desc = "CMake Quick Build (choose target)" },
		{ "<leader>cq", ":CMakeQuickRun<cr>", desc = "CMake Run (choose target)" },

		-- Misc:
		{ "<leader>cs", ":CMakeStopRunner<cr>:CMakeCloseRunner<cr>", desc = "CMake Stop runner" },
		{ "<leader>cS", ":CMakeStopExecutor<cr>:CMakeCloseExecutor<cr>", desc = "CMake Stop executor" },
		{ "<leader>cf", ":CMakeShowTargetFiles<cr>", desc = "CMake Show Target Files" },
	},
}
