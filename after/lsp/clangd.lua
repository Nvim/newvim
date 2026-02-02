return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--header-insertion-decorators",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "--offset-encoding=utf-16",
  },
  root_dir = vim.fs.root(
    vim.fs.joinpath(vim.env.PWD, "compile_commands.json"),
    { ".clangd", ".clang-format", ".clang-tidy" }
  ) or vim.fn.getcwd(),
  on_attach = function(_, bufnr)
    require("clangd_extensions").setup({
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    })

    vim.keymap.set("n", "<leader>ls", function()
      vim.cmd("ClangdSwitchSourceHeader")
    end, { buffer = bufnr, remap = false, silent = true, desc = "ClangdSwitchSourceHeader" })
  end,
}
