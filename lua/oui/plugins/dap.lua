return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        {
          "<leader>de",
          function() require("dapui").eval(nil, { enter = true }) end,
          { desc = "DAPUI Eval" },
        },
      },
			opts = {},
			config = function(_, opts)
				local dap, dapui = require("dap"), require("dapui")
				dapui.setup(opts)
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			end,
		},
		"nvim-neotest/nvim-nio",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		{
			"leoluz/nvim-dap-go",
			opts = {},
		},
	},

	-- OPTS
	opts = function()
		local dap, dapui = require("dap"), require("dapui")
		require("nvim-dap-virtual-text").setup()
		require("dap-go").setup()
		require("overseer").enable_dap()

		if not dap.adapters["gdb"] then
			require("dap").adapters["gdb"] = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}
		end
		if not dap.adapters["codelldb"] then
			require("dap").adapters["codelldb"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = {
						"--port",
						"${port}",
					},
				},
			}
		end
		if not dap.adapters["lldb"] then
			require("dap").adapters["lldb"] = {
				type = "executable",
				command = "lldb-dap", -- adjust as needed, must be absolute path
				name = "lldb",
			}
		end
		for _, lang in ipairs({ "c", "cpp" }) do
			dap.configurations[lang] = {
				{
					name = "Launch file (gdb)",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Launch file (lldb)",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
				{
					name = "Attach to process (lldb)",
					type = "lldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					args = {},
					cwd = "${workspaceFolder}",
				},
				{
					type = "codelldb",
					request = "launch",
					name = "Launch file (Codelldb)",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process (Codelldb)",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,

  -- Keys
  -- stylua: ignore
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Breakpoint" } },
    { "<leader>dc", function() require("dap").continue() end,          { desc = "DAP continue/start" } },
    { "<Leader>dx", function() require("dap").terminate() end,         { desc = "DAP Terminate" } },
    { "<Leader>do", function() require("dap").step_over() end,         { desc = "DAP Step Over" } },
    { "<leader>dr", function() require("dap").restart() end,           { desc = "DAP Restart" } },

    { "<F1>",       function() require("dap").continue() end,          { desc = "DAP Continue" } },
    { "<F2>",       function() require("dap").step_into() end,         { desc = "DAP Step Into" } },
    { "<F3>",       function() require("dap").step_over() end,         { desc = "DAP Step Over" } },
    { "<F4>",       function() require("dap").step_out() end,          { desc = "DAP Step Out" } },
    { "<F5>",       function() require("dap").step_back() end,         { desc = "DAP Step Back" } },
  },

	-- Config:
	config = function()
		-- setup dap config by VsCode launch.json file
		-- local vscode = require("dap.ext.vscode")
		-- local json = require("plenary.json")
		-- vscode.json_decode = function(str)
		--   return vim.json.decode(json.json_strip_comments(str))
		-- end

		local sign = vim.fn.sign_define
		local dap = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		}
		sign("Stopped", { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DiagnosticError", numhl = "DapStoppedLine" })
		sign("DapBreakpoint", { text = " "})
		sign("DapBreakpointCondition", { text = " "})
		sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
	end,
}
