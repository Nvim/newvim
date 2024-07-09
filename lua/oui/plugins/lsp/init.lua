-- TODO: jdtls (https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/setup-with-nvim-jdtls.md)
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

local set_lsp_mappings = function(bufnr)
  local set = vim.keymap.set

  set_lsp_telescope_mappings(bufnr)

  -- set("n", "<leader>ld", function()
  -- 	vim.lsp.buf.definition()
  -- end, { buffer = bufnr, remap = false, silent = true, desc = "LSP definition" })
  set("n", "<leader>lD", function()
    vim.lsp.buf.declaration()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP declaration" })
  set("n", "<leader>lh", function()
    vim.lsp.buf.hover()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP hover info" })
  set("n", "<leader>lf", function()
    vim.diagnostic.open_float()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostic" })
  set("n", "<leader>lj", function()
    vim.diagnostic.goto_next()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP next diagnostic" })
  set("n", "<leader>lk", function()
    vim.diagnostic.goto_prev()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP prev diagnostic" })
  set("n", "<leader>la", function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP code action" })
  set("n", "<leader>lR", function()
    vim.lsp.buf.rename()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP rename" })
  set("n", "<leader>lS", function()
    vim.lsp.buf.signature_help()
  end, { buffer = bufnr, remap = false, silent = true, desc = "LSP signature help" })
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

local M = {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp", "nvimdev/lspsaga.nvim" },
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

    local lspsaga = require("lspsaga")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local on_attach = function(_, bufnr)
      set_lspsaga_mappings(bufnr)
    end

    require("lspconfig").lua_ls.setup({
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,
      settings = { Lua = {} },
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").cssls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").bashls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").nixd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").emmet_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").tailwindcss.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").ruff_lsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").volar.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    require("lspconfig").tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- clangd: special settings:
    require("lspconfig").clangd.setup({
      cmd = { "clangd", "--offset-encoding=utf-16" },
      on_attach = function(_, bufnr)
        set_lspsaga_mappings(bufnr)
        vim.keymap.set("n", "<leader>ls", function()
          vim.cmd("ClangdSwitchSourceHeader")
        end, { buffer = bufnr, remap = false, silent = true, desc = "ClangdSwitchSourceHeader" })
      end,
    })

    -- require("lspconfig").glsl_analyzer.setup({})
  end,
}

return M
