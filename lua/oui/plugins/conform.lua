-- Formatting
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
    },

    config = function()
      require("conform").setup({
        formatters_by_ft = {

          c = { "clang_format" },
          cpp = { "clang_format" },
          lua = { "stylua" },
          python = { "isort", "black" }, -- isort for imports, black for syntax.
          php = { "pint" },

          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          yml = { "prettier" },
          markdown = { "prettier" },
					tex = { "latexindent" },
          css = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          nix = { "nixfmt" },
        },

        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
    end,
  },
}
