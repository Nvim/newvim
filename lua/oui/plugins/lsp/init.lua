-- TODO: jdtls (https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/setup-with-nvim-jdtls.md)

local set_my_mappings = function(bufnr)
  local opts = { buffer = bufnr, remap = false }
  local set = vim.keymap.set
  local lspsaga = require("lspsaga")

  -- TODO: make which-key work on these
  -- set("n", "<leader>ld", function()
  -- 	vim.lsp.buf.definition()
  -- end, opts, { desc = "LSP definition" })
  set("n", "<leader>lD", function()
    vim.lsp.buf.declaration()
  end, opts, { desc = "LSP declaration" })
  set("n", "<leader>lh", function()
    -- vim.lsp.buf.hover()
    vim.cmd("Lspsaga hover_doc")
  end, opts, { desc = "LSP hover info" })
  set("n", "<leader>lf", function()
    vim.diagnostic.open_float()
  end, opts, { desc = "LSP diagnostic" })
  set("n", "<leader>lj", function()
    -- vim.diagnostic.goto_next()
    vim.cmd("Lspsaga diagnostic_jump_next")
  end, opts, { desc = "LSP next diagnostic" })
  set("n", "<leader>lk", function()
    -- vim.diagnostic.goto_prev()
    vim.cmd("Lspsaga diagnostic_jump_prev")
  end, opts, { desc = "LSP prev diagnostic" })
  set("n", "<leader>la", function()
    -- vim.lsp.buf.code_action()
    vim.cmd("Lspsaga code_action")
  end, opts, { desc = "LSP code action" })
  set("n", "<leader>lR", function()
    -- vim.lsp.buf.rename()
    vim.cmd("Lspsaga rename")
  end, opts, { desc = "LSP rename" })
  set("n", "<leader>lS", function()
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
  set("n", "<leader>ld", "<cmd>Lspsaga peek_definition<cr>", { desc = "LSP definition" })
  set("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP implementation" })
  set("n", "<leader>le", "<cmd>Telescope diagnostics<cr>", { desc = "LSP diagnostics" })
  set("n", "<A-d>", "<cmd>Lspsaga term_toggle<cr>", { desc = "Terminal" })
end

local server_list = require("oui.utils.server_list")
if (server_list == nil) then
  print("Failed to load lsp server list")
end

if (server_list.others == nil or server_list.lsps == nil) then
  print("Failed to load subtable")
end


local M = {
  {
    "williamboman/mason.nvim",
    -- cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      ensure_installed = server_list.others,
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
          source = "if_many",
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
        ensure_installed = server_list.lsps,
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
          lsp_zero.setup_servers({ server_list.lsps }, { exclude = { "lua_ls", "clangd", "tsserver" } }),

          -- setup lua for neovim (lspzero provided)
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          -- fix illuminate + null_ls conflict TODO: try without it
          clangd = function()
            require("lspconfig").clangd.setup({
              cmd = { "clangd", "--offset-encoding=utf-16" },
              on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                local set = vim.keymap.set
                set("n", "<leader>ls", function()
                  vim.cmd("ClangdSwitchSourceHeader")
                end, opts, { desc = "Clangd Switch Source Header" })
                lsp_zero.on_attach(client, bufnr)
                require("clangd_extensions.inlay_hints").setup_autocmd()
                require("clangd_extensions.inlay_hints").set_inlay_hints()
              end,
            })
          end,
          tsserver = lsp_zero.noop,
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
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
return M
