-- TODO: jdtls (https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/setup-with-nvim-jdtls.md)

local set_my_mappings = function(bufnr)
  local opts = { buffer = bufnr, remap = false }
  local set = vim.keymap.set

  -- TODO: make which-key work on these
  -- set("n", "<leader>ld", function()
  -- 	vim.lsp.buf.definition()
  -- end, opts, { desc = "LSP definition" })
  set("n", "<leader>lD", function()
    vim.lsp.buf.declaration()
  end, opts, { desc = "LSP definition" })
  set("n", "<leader>lh", function()
    vim.lsp.buf.hover()
  end, opts, { desc = "LSP hover info" })
  set("n", "<leader>lf", function()
    vim.diagnostic.open_float()
  end, opts, { desc = "LSP diagnostic" })
  set("n", "<leader>lj", function()
    vim.diagnostic.goto_next()
  end, opts, { desc = "LSP next diagnostic" })
  set("n", "<leader>lk", function()
    vim.diagnostic.goto_prev()
  end, opts, { desc = "LSP prev diagnostic" })
  set("n", "<leader>la", function()
    vim.lsp.buf.code_action()
  end, opts, { desc = "LSP code action" })
  set("n", "<leader>lR", function()
    vim.lsp.buf.rename()
  end, opts, { desc = "LSP rename" })
  set("n", "<leader>ls", function()
    vim.lsp.buf.signature_help()
  end, opts, { desc = "LSP signature help" })
  -- set("n", "<leader>vws", function()
  -- 	vim.lsp.buf.workspace_symbol()
  -- end, opts)
  -- vim.keymap.set("n", "<leader>vrr", function()
  -- 	vim.lsp.buf.references()
  -- end, opts)

  set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })
  set("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "LSP symbols" })
  set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP definition" })
  set("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP implementation" })
  set("n", "<leader>le", "<cmd>Telescope diagnostics<cr>", { desc = "LSP diagnostics" })
end

local M = {
  {
    "williamboman/mason.nvim",
    lazy = false,
    -- cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      ensure_installed = {
        -- lint
        -- "eslint_d", -- linter
        "mypy", --linter(static type check)
        "ruff", --fast linting

        -- format
        "prettier",        -- formatter
        -- "clang-format", --formatter
        "blade-formatter", --formatter
        "pint",            --formatter
        "stylua",          -- formatter
        "isort",           --formatter
        "black",           --formatter
        "latexindent",     --formatter
      },
    },

    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  -- Autocompletion: view cmp.lua

  -- LSP, servers are configured in the mason-lspconfig plugins' config, not directly lspconfig
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      -- some ricing before setting up LSP:
      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          source = "always",
        },
      })

      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        set_my_mappings(bufnr)
      end)

      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })

      require("lspconfig").glsl_analyzer.setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "jdtls",
          "intelephense",
          "html",
          "cssls",
          "volar",
          "emmet_language_server",
          "tsserver",
          "eslint",
          "lua_ls",
          "pyright",
          -- "glsl_analyzer",
          "texlab",
        },
        handlers = {
          lsp_zero.default_setup,
          lsp_zero.set_server_config({
            capabilities = {
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            },
          }),
          lsp_zero.setup_servers({
            "bashls",
            "jdtls",
            "intelephense",
            "html",
            "cssls",
            "volar",
            "emmet_language_server",
            "eslint",
            "lua_ls",
            "pyright",
            "texlab",
          }),

          -- setup lua for neovim (lspzero provided)
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          -- fix illuminate + null_ls conflict TODO: try without it
          clangd = function()
            require("lspconfig").clangd.setup({
              cmd = { "clangd", "--offset-encoding=utf-16" },
            })
          end,
          -- tsserver = function()
          -- 	require("lspconfig").tsserver.setup({
          -- 		init_options = {
          -- 			preferences = {
          -- 				-- disableSuggestions = true,
          -- 				disableSuggestions = false,
          -- 			},
          -- 		},
          -- 	})
          -- end,
        },
      })
    end,
  },

  -- tsserver plugin, better than normal lsp
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  }
}
return M
