-- 		cmp.setup({
-- 			completion = {
-- 				completeopt = "menu,menuone,preview,noselect",
-- 			},
-- 			experimental = {
-- 				ghost_text = true,
-- 			},
-- 			-- configure lspkind for vs-code like pictograms in completion menu
-- 			formatting = {
-- 				fields = { "abbr", "kind" },
-- 				format = require("lspkind").cmp_format({
-- 					mode = "symbol", -- show only symbol annotations
-- 					maxwidth = 20, -- prevent the popup from showing more than provided characters
-- 					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
-- 				}),
-- 			},
--
-- 		})
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",           -- source for text in buffer
    "hrsh7th/cmp-path",             -- source for file system paths
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",             -- snippet engine
    "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",         -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local lsp_zero = require("lsp-zero")
    local cmp_action = lsp_zero.cmp_action()
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer",  keyword_length = 3 },
        -- { name = "codeium"},
      },
      window = {
        completion = cmp.config.window.bordered({
          -- border = "rounded",
          winhighlight = "CursorLine:PmenuSel",
          side_padding = 0,
          col_offset = -3,
        }),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-f>"] = cmp_action.luasnip_jump_forward(), --navigate snippet placeholders
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        ["<C-Space>"] = cmp.mapping.complete(),        -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),               -- close completion window
        -- newline if no selection:
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      }),
      -- formatting = lsp_zero.cmp_format(),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = require("lspkind").cmp_format({
          mode = "symbol",
          menu = {
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
          },
          maxwidth = 40,
          ellipsis_char = "..",
        }),
        before = function(entry, vim_item)
          vim_item.abbr = vim_item.abbr:match("[^(]+")
        end,
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        name = "path"
      }, { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } })
    })

    -- cmp.setup.cmdline({ '/' }, {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = "buffer" }
    --   }
    -- })
    -- enable autopairs to insert () after function completion:
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
