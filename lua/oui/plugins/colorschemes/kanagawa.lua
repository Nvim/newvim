return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  -- priority = 1000,
  config = function()
    require("kanagawa").setup({
      transparent = false,
      terminalColors = true,
      compile = false, -- enable compiling the colorscheme
      undercurl = true,
      dimInactive = false,

      commentStyle = { italic = true },
      functionStyle = { bold = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},

      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },

      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },

      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptNormal = { bg = "none" },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "none" },
          TelescopePreviewNormal = { bg = "none" },
          TelescopePreviewBorder = { bg = "none", fg = theme.ui.bg_dim },
        }
      end,
    })

    -- vim.cmd("colorscheme kanagawa")
  end,
}
