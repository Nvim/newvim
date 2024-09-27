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
    cmake_executor = { name = "quickfix" },
    cmake_runner = { name = "quickfix" },
    cmake_dap_configuration = { -- debug settings for cmake
      name = "CMake Debugger",
      type = "lldb",
      request = "launch",
      stopOnEntry = false,
      runInTerminal = true,
      console = "integratedTerminal",
    },
  },
  -- mappings:
  keys = {
    { "<leader>cg", ":CMakeGenerate<cr>",          { desc = "CMake Generate" } },
    { "<leader>cb", ":CMakeBuild<cr>",             { desc = "CMake Build" } },
    { "<leader>cB", ":CMakeQuickBuild<cr>",        { desc = "CMake Build Target" } },
    { "<leader>cr", ":CMakeRun<cr>",               { desc = "CMake Run" } },
    { "<leader>cR", ":CMakeQuickRun<cr>",          { desc = "CMake Run Target" } },
    { "<leader>cd", ":CMakeDebug<cr>",             { desc = "CMake Debug" } },
    { "<leader>ct", ":CMakeSelectBuildTarget<cr>", { desc = "CMake Select Target" } },
  },
}
