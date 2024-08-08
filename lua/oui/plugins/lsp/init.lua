local set_lsp_telescope_mappings = function(bufnr)
  local opts = { buffer = bufnr, remap = false, silent = true }
  local set = vim.keymap.set
  set(
    "n",
    "<leader>lr",
    "<cmd>Telescope lsp_references<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "LSP references" }
  )
  set(
    "n",
    "<leader>lS",
    "<cmd>Telescope lsp_workspace_symbols<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "LSP symbols" }
  )
  set(
    "n",
    "<leader>li",
    "<cmd>Telescope lsp_implementations<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "LSP implementation" }
  )
  set(
    "n",
    "<leader>le",
    "<cmd>Telescope diagnostics<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostics" }
  )
end

local set_lspsaga_mappings = function(bufnr)
  local opts = { buffer = bufnr, remap = false, silent = true }
  local set = vim.keymap.set
  set_lsp_telescope_mappings(bufnr)
  -- local lspsaga = require("lspsaga")

  set(
    "n",
    "<A-d>",
    "<cmd>Lspsaga term_toggle<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "Terminal" }
  )
  set(
    "n",
    "<leader>ld",
    "<cmd>Lspsaga peek_definition<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "LSP definition" }
  )
  set("n", "<leader>lD", function()
    vim.lsp.buf.declaration()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP declaration" })
  set("n", "<leader>lh", function()
    vim.cmd("Lspsaga hover_doc")
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP hover info" })
  set("n", "<leader>lf", function()
    vim.diagnostic.open_float()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostic" })
  set("n", "<leader>lj", function()
    vim.cmd("Lspsaga diagnostic_jump_next")
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP next diagnostic" })
  set("n", "<leader>lk", function()
    vim.cmd("Lspsaga diagnostic_jump_prev")
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP prev diagnostic" })
  set("n", "<leader>la", function()
    vim.cmd("Lspsaga code_action")
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP code action" })
  set("n", "<leader>lR", function()
    vim.cmd("Lspsaga rename")
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP rename" })
  set("n", "<leader>lS", function()
    vim.lsp.buf.signature_help()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP signature help" })
end

return {
  {
    "yioneko/nvim-vtsls",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", "nvimdev/lspsaga.nvim" },
    },
    opts = {},
    config = function()
      local lspconfig = require("lspconfig")
      local lspsaga = require("lspsaga")
      local vtsls = require("vtsls")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(_, bufnr)
        set_lspsaga_mappings(bufnr)
      end

      lspconfig.volar.setup({
        enabled = true,
      })

      lspconfig.vtsls.setup({
        on_attach = function(_, bufnr)
          set_lspsaga_mappings(bufnr)
          -- vim.keymap.del("n", "<leader>ld", { buffer = bufnr })
          vim.keymap.set(
            "n",
            "<leader>lF", -- TODO: override leader+ld
            "<cmd>VtsExec goto_source_definition<cr>",
            { desc = "Go to Typescript source definition" }
          )
          vim.keymap.set(
            "n",
            "<leader>lw",
            "<cmd>VtsExec file_references<cr>",
            { desc = "Typescript file references" }
          )
          vim.keymap.set(
            "n",
            "<leader>lI",
            "<cmd>VtsExec organize_imports<cr>",
            { desc = "Typescript Organize imports" }
          )
          vim.keymap.set(
            "n",
            "<leader>lM",
            "<cmd>VtsExec add_missing_imports<cr>",
            { desc = "Typescript import missing" }
          )
          vim.keymap.set(
            "n",
            "<leader>lU",
            "<cmd>VtsExec remove_unused_imports<cr>",
            { desc = "Typescript remove unused imports" }
          )
          vim.keymap.set(
            "n",
            "<leader>lT",
            "<cmd>VtsExec select_ts_version<cr>",
            { desc = "Typescript select TS version" }
          )
        end,
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },

        -- Config
        settings = {
          complete_function_calls = true,
          vtsls = {

            -- True = don't use the bundled typescript version, use VTSLS bundled version instead.
            -- Use command typescript.selectTypescriptVersion to switch
            autoUseWorkspaceTsdk = false,

            experimental = {
              completion = {
                -- Optimize sorting of entries server-side
                enableServerSideFuzzyMatch = true,
              },
            },

            typescript = {
              -- Inlay hints setup:
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },

              -- Misc:
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
            },

            -- For Vue:
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "/home/naim/.npm-packages/lib/node_modules/@vue/language-server",
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      })

      lspconfig.eslint.setup({
        settings = {
          workingDirectories = { mode = "auto" },
        },
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
