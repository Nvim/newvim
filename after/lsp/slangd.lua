local settings = {
  slang = {
    inlayHints = {
      deducedTypes = false,
      parameterNames = false,
    },
  },
}

-- Add Vulkan SDK search paths if using SDK
if vim.env.VULKAN_SDK then
  settings.slang.additionalSearchPaths = {
    vim.env.VULKAN_SDK .. '/bin',
    vim.env.VULKAN_SDK .. '/lib/slang-standard-module-2026.8',
  }
end

return {
  settings = settings,
}
