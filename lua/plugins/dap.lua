vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })

-- MAPS --
local map = vim.keymap.set
map("n", "<F1>", function() require("dap").continue() end)
map("n", "<F2>", function() require("dap").step_into() end)
map("n", "<F3>", function() require("dap").step_over() end)
map("n", "<F4>", function() require("dap").step_out() end)
map("n", "<F5>", function() require("dap").step_back() end)

map('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
map('n', '<Leader>dB', function() require('dap').list_breakpoints() end)
map('n', '<Leader>dr', function() require('dap').repl.open() end)
map('n', '<Leader>dc', function() require('dap').run_to_cursor() end)
map('n', '<Leader>dl', function() require('dap').run_last() end)
map('n', '<Leader>dx', function() require('dap').terminate() end)
map('n', '<Leader>dX', function() require('dap').restart() end)

vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- ADAPTERS --
local dap = require("dap")
dap.adapters["gdb"] = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.adapters["codelldb"] = {
  type = "executable",
  command = "codelldb",
}
dap.adapters["lldb"] = {
  type = "executable",
  command = "lldb-dap",
  name = "lldb",
}

-- LANGUAGE CONFIGS --
for _, lang in ipairs({ "c", "cpp" }) do
  dap.configurations[lang] = {
    {
      name = "Launch (gdb)",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
    {
      name = "Launch (lldb)",
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
      name = "Launch (Codelldb)",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Attach (Codelldb)",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
