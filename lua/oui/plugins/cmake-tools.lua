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
  },
  -- mappings:
  keys = {
    { "<leader>cg", ":CMakeGenerate",          { desc = "CMake Generate" } },
    { "<leader>cb", ":CMakeBuild",             { desc = "CMake Build" } },
    { "<leader>cB", ":CMakeQuickBuild",        { desc = "CMake Build Target" } },
    { "<leader>cr", ":CMakeRun",               { desc = "CMake Run" } },
    { "<leader>cR", ":CMakeQuickRun",          { desc = "CMake Run Target" } },
    { "<leader>cd", ":CMakeDebug",             { desc = "CMake Debug" } },
    { "<leader>ct", ":CMakeSelectBuildTarget", { desc = "CMake Select Target" } },
  },
}
