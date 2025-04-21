-- Gruvbox baby:
return {
  "luisiacc/gruvbox-baby",
  lazy = true,
  -- priority = 1000,
  config = function()
    vim.g.gruvbox_baby_use_original_palette = 0 -- OG gruvbox
    vim.g.gruvbox_baby_background_color = "dark" -- sets background colors to None
    vim.g.gruvbox_baby_transparent_mode = 0    -- sets background colors to None
    vim.g.gruvbox_baby_function_style = "bold"
    vim.g.gruvbox_baby_keyword_style = "italic"
    vim.g.gruvbox_baby_comment_style = "italic"
    vim.g.gruvbox_baby_string_style = "nocombine"
    vim.g.gruvbox_baby_variable_style = "NONE"
    vim.g.gruvbox_baby_color_overrides = {} -- override color palette with your custom colors

    -- vim.g.gruvbox_baby_telescope_theme = 1

    -- Each highlight group must follow the structure:
    -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
    -- See also :h highlight-guifg
    -- Example:
    -- vim.g.gruvbox_baby_highlights = { Normal = { fg = "#123123", bg = "NONE", style = "underline" } }

    -- vim.cmd("colorscheme gruvbox-baby")
  end,
}
