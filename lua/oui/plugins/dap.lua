return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("dapui").setup()
    local dap, dapui = require("dap"), require("dapui")
    require("nvim-dap-virtual-text").setup()

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap" },
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
      },
    }
    dap.configurations.cpp = dap.configurations.c

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

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP continue/start" })
    vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "DAP Terminate" })
    vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { desc = "DAP Step Over" })
    vim.keymap.set("n", "<leader>dr", dap.restart)
    vim.keymap.set("n", "<leader>de", function()
      require("dapui").eval(nil, { enter = true })
    end, { desc = "DAPUI Eval" })

    vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DAP Step Into" })
    vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DAP Step Over" })
    vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DAP Step Out" })
    vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DAP Step Back" })
  end,
}
