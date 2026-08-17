if vim.g.neovide then
  require("neovide")
end

-- MAPS:
local map = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map('n', '<leader>ss', '<cmd>source ~/.config/nvim/init.lua<cr>')
map('n', '<leader>v', 'gcc')
map('v', '<leader>v', 'gc')
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("n", "<right>", ":vertical resize +2<cr>")
map("n", "<left>", ":vertical resize -2<cr>")
map("n", "<down>", ":resize +2<cr>")
map("n", "<up>", ":resize -2<cr>")
map("n", "<leader>co", "gc")
map("v", "<leader>/", "gcc")
vim.keymap.set('t', '<C-b>', [[<C-\><C-n>]], { noremap = true })

-- OPTS:
local opt = vim.opt
opt.exrc = true
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.cursorline = true
vim.opt.scrolloff = 8
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.swapfile = false
opt.virtualedit = "block"
opt.confirm = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.list = true
opt.listchars = "tab: "

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.inccommand = "split"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- diagnostics symbols
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

-- FT:
vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
  pattern = {
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
  },
  extension = {
    ["vs"] = "glsl",
    ["fs"] = "glsl",
    ["vert"] = "glsl",
    ["frag"] = "glsl",
    ["shader"] = "glsl",
    ["glsl"] = "glsl",
    ["comp"] = "glsl",
    ["fsh"] = "glsl",
    ["vsh"] = "glsl",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "glsl",
  callback = function()
    local opt = vim.opt_local
    opt.tabstop = 4
    opt.softtabstop = 4
    opt.shiftwidth = 4
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd({"TextYankPost", "TextPutPost"}, {
  callback = function()
    vim.hl.hl_op()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true, }),
  callback = function()
    vim.o.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.o.cursorline = false
  end,
})

-- Built-ins:
vim.g.editorconfig = true

-- PLUGINS:
vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",
  -- "https://github.com/zenbones-theme/zenbones.nvim",
  "https://github.com/aktersnurra/no-clown-fiesta.nvim",
  "https://github.com/rktjmp/lush.nvim",
  { src = "https://github.com/saghen/blink.cmp",                            version = vim.version.range("^1") },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  "https://github.com/Wansmer/treesj",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/p00f/clangd_extensions.nvim",
  "https://github.com/obsidian-nvim/obsidian.nvim",
  "https://github.com/danymat/neogen",
  "https://github.com/esmuellert/codediff.nvim",
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

-- -----------
-- CONFIGS: --
-- -------- --

require("plugins.dap")

-- Colorscheme:
-- vim.g.zenbones_transparent_background = false
-- vim.g.zenbones_darkness = 'stark'
-- vim.cmd.colorscheme("zenbones")
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
require("no-clown-fiesta").setup({
  -- theme = "dark", -- supported themes are: dark, dim, light
  transparent = true, -- Enable this to disable the bg color
  styles = {
    -- You can set any of the style values specified for `:h nvim_set_hl`
    -- comments = {},
    -- functions = {},
    -- keywords = {},
    -- lsp = {},
    -- match_paren = {},
    -- type = {},
    -- variables = {},
  },
})
vim.cmd[[colorscheme no-clown-fiesta]]


-- LSP setup:
vim.lsp.enable({
  "lua_ls",
  "gopls",
  "clangd",
  "vtsls",
  "vue_ls",
  "svelte",
  "html",
  "cssls",
  "bashls",
  "glsl_analyzer",
  "slangd",
  "nixd",
  "emmet_language_server",
  "tailwindcss",
  "ruff",
  "basedpyright",
  "docker_language_server",
  "neocmake",
  "zls",
  -- "angularls",
  -- "intelephense",
  -- "metals"
})

require("mason").setup()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local has_blink, blink = pcall(require, "blink.cmp")
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if client and has_blink then
      client.capabilities = blink.get_lsp_capabilities(capabilities)
    end
    if client and client.name == 'slangd' then
      local slangd_capabilities = vim.tbl_deep_extend('force', capabilities, {
        offsetEncoding = { 'utf-8', 'utf-16' },
        textDocument = {
          semanticTokens = vim.NIL, -- Disable (causes errors)
        },
      })
      client.capabilities = slangd_capabilities
      client.server_capabilities.semanticTokensProvider = nil
    end


    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end)
    vim.keymap.set("n", "<leader>lf", function()
      vim.diagnostic.open_float()
    end)

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
        max_height = 40,
        max_width = 120,
      })
    end, { buffer = true })
  end,
})

-- Completion:
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  snippets = {
    preset = 'luasnip',
    active = function(filter)
      local snippet = require "luasnip"
      local blink = require "blink.cmp"
      if snippet.in_snippet() and not blink.is_visible() then
        return true
      else
        if not snippet.in_snippet() and vim.fn.mode() == "n" then snippet.unlink_current() end
        return false
      end
    end,
  },
  keymap = {
    preset = "default",
    ["<C-k>"] = {},
    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  cmdline = {
    completion = {
      menu = {
        auto_show = function(ctx)
          return vim.fn.getcmdtype() == ":"
          -- enable for inputs as well, with:
          -- or vim.fn.getcmdtype() == '@'
        end,
      },
    },
  },

  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    list = {
      max_items = 20,
      selection = { preselect = true, auto_insert = true },
    },

    menu = {
      border = "single",
      scrollbar = false,
      draw = {
        treesitter = { "lsp" },
        columns = {
          { "kind_icon" },
          { "label",    "label_description", gap = 1 },
          { "kind",     "source_name",       gap = 1 },
        },
      },
    },
    documentation = {
      window = { border = "single" },
    },

    ghost_text = {
      enabled = false,
    },
  },

  signature = {
    enabled = true,
  },

  -- default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  }
})

-- Formatting:
require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    cmake = { "cmake_format" },
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff" },
    php = { "pint" },
    go = { "goimports", "gofumpt" },
    nix = { "nixfmt" },
    sh = { "shfmt" },
    scala = { "scalafmt" },

    html = { "prettierd" },
    json = { "prettierd" },
    yaml = { "prettierd" },
    yml = { "prettierd" },
    markdown = { "prettierd" },
    tex = { "latexindent" },
    css = { "prettierd" },
    sql = { "sqlfmt" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    vue = { "prettierd" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 1500, lsp_format = "fallback" }
  end,
})
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- User command to format a range:
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.keymap.set("n", "<M-f>", ":Format<cr>", { desc = "Format buffer" })
vim.keymap.set("v", "<M-f>", ":Format<cr>", { desc = "Format range" })
vim.b.disable_autoformat = true
vim.g.disable_autoformat = true

-- FZF:
require("fzf-lua").setup({
  winopts = {
    row = 1,
    col = 0,
    height = 0.3,
    width = 1,
    backdrop = 70,
    border = "single",
    preview = {
      border = "single",
      flip_columns = 80,
    },
  },
})
require("fzf-lua").register_ui_select()
map("n", "<leader>ff", "<cmd>FzfLua files<cr>")
map("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>")
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>")
map("n", "<leader>fz", "<cmd>FzfLua lgrep_curbuf<cr>")
map("n", "<leader>fw", "<cmd>FzfLua lgrep_curword<cr>")
map("n", "<leader>fq", "<cmd>FzfLua lgrep_quickfix<cr>")
map("n", "<leader>fg", "<cmd>FzfLua live_grep_native<cr>")
map("n", "<leader>fG", "<cmd>FzfLua resume<cr>")
map("n", "<leader>lE", "<cmd>FzfLua diagnostics_document<cr>")
map("n", "<leader>le", "<cmd>FzfLua diagnostics_workspace<cr>")
map("n", "<leader>lZ", "<cmd>FzfLua lsp_document_symbols<cr>")
map("n", "<leader>lz", "<cmd>FzfLua lsp_live_workspace_symbols<cr>")
map("n", "<leader>lc", "<cmd>FzfLua lsp_outgoing_calls<cr>")
map("n", "<leader>lC", "<cmd>FzfLua lsp_incoming_calls<cr>")
map("n", "<leader>li", "<cmd>FzfLua lsp_implementations<cr>")
map("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>")
map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>")
map("n", "<leader>lD", "<cmd>FzfLua lsp_definitions<cr>")
map("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<cr>")
map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>")
map("n", "<leader>lx", "<cmd>FzfLua lsp_finder<cr>")
map("n", "<leader>fm", "<cmd>FzfLua marks<cr>")
map("n", "<leader>fQ", "<cmd>FzfLua quickfix<cr>")
map("n", "<leader>fr", "<cmd>FzfLua registers<cr>")
map("n", "<leader>fj", "<cmd>FzfLua jumps<cr>")
map("n", "<leader>fl", "<cmd>FzfLua loclist<cr>")
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>")
map("n", "<leader>gC", "<cmd>FzfLua git_bcommits<CR>")
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>")
map("n", "<leader>S", function()
  require 'fzf-lua'.spell_suggest({ winopts = { relative = 'cursor', row = 1.01, col = 0, height = 0.2, width = 0.2 } })
end)
map("n", "<leader>:", "<cmd>FzfLua command_history<cr>")
map("n", "<leader>fp", "<cmd>FzfLua help_tags<cr>")
map("n", "<leader>fP", "<cmd>FzfLua man_pages<cr>")

-- Treesitter:

local ts = require('nvim-treesitter')
ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site/parser",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    local filetype = vim.bo.filetype
    if filetype and filetype ~= "" then
      local success = pcall(function()
        vim.treesitter.start()
      end)
      if not success then
        return
      end
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.o.foldlevel = 99 -- start with everything unfolded
      -- experimental:
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

ts.install {
  "c",
  "cpp",
  "java",
  "python",
  "javascript",
  "typescript",
  "go",
  "glsl",
  "slang",
  "vue",
  "html",
  "css",
  "lua",
  "tsx",
  "json",
  "yaml",
  "toml",
  "helm",
  "bash",
  "vim",
  "dockerfile",
  "cmake",
  "make",
  "gitignore",
  "markdown",
  "markdown_inline",
  "latex",
  "bibtex",
  "svelte",
}

-- Textobjects:
vim.g.no_plugin_maps = true
require("nvim-treesitter-textobjects").setup()
vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
end)

-- TreeSJ:
require("treesj").setup({
  use_default_keymaps = true,
  check_syntax_error = false,
  max_join_length = 120,
  cursor_behavior = "hold",
  dot_repeat = true,
  on_error = nil,
})
map("n", "<space>ts", "<cmd>TSJSplit<CR>", { desc = "TSJ Split" })
map("n", "<space>tj", "<cmd>TSJJoin<CR>", { desc = "TSJ Join" })

-- Git:
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>gr', gitsigns.reset_hunk)
    map('n', '<leader>gR', gitsigns.reset_buffer)
    map('n', '<leader>gp', gitsigns.preview_hunk)
    map('n', '<leader>gi', gitsigns.preview_hunk_inline)
    map('n', '<leader>gb', function()
      gitsigns.blame_line({ full = true })
    end)
    map('n', '<leader>gd', gitsigns.diffthis)
    map('n', '<leader>gD', function()
      gitsigns.diffthis('~')
    end)
    map('n', '<leader>gQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>gq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>gtb', gitsigns.toggle_current_line_blame)
  end
}

-- Lualine:
require("lualine").setup({
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
      },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "lsp_status", "diagnostics" },
    lualine_x = { "location" },
    lualine_y = { "filetype" },
    lualine_z = { "filename" },
  },
  extensions = { "fzf", "lazy", "man", "neo-tree", "nvim-dap-ui", "overseer", "quickfix" },
})

-- MINI:
require("mini.cursorword").setup()
require("mini.move").setup()
require("mini.icons").setup()

local MiniFiles = require("mini.files")
MiniFiles.setup({})
local minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end
vim.keymap.set("n", "<leader>e", function()
  minifiles_toggle()
end, { desc = "Toggle Files" })

local ai = require("mini.ai")
ai.setup({
  n_lines = 100,
  custom_textobjects = {
    -- Code:
    o = ai.gen_spec.treesitter({ -- Blocks
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },

    -- Functions:
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    u = ai.gen_spec.function_call(),
    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),

    -- Assignments:
    g = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
    r = ai.gen_spec.treesitter({ a = "@assignment.rhs", i = "@assignment.rhs" }),
    R = ai.gen_spec.treesitter({ a = "@assignment.lhs", i = "@assignment.lhs" }),

    -- Misc:
    G = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    d = { "%f[%d]%d+" },
    e = {
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
  },
})

require("mini.indentscope").setup({
  symbol = "▏",
  options = { try_as_border = true },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "Trouble",
    "alpha",
    "dashboard",
    "fzf",
    "help",
    "lazy",
    "mason",
    "neo-tree",
    "notify",
    "snacks_dashboard",
    "snacks_notif",
    "snacks_terminal",
    "snacks_win",
    "toggleterm",
    "trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

require("mini.surround").setup({
  highlight_duration = 1000,
  mappings = {
    add = "sa",            -- Add surrounding in Normal and Visual modes
    delete = "sd",         -- Delete surrounding
    find = "sf",           -- Find surrounding (to the right)
    find_left = "sF",      -- Find surrounding (to the left)
    highlight = "sh",      -- Highlight surrounding
    replace = "sr",        -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`
    suffix_last = "l",     -- Suffix to search with "prev" method
    suffix_next = "n",     -- Suffix to search with "next" method
  },
  n_lines = 20,
  search_method = "cover",
  silent = false,
}
)

-- Obsidian
require("obsidian").setup({
  legacy_commands = false,
  ui = { enable = false },
  workspaces = { { name = "Obsidian", path = "~/Sync/Obsidian", }, },
  notes_subdir = "inbox",
  new_notes_location = "notes_subdir",
  frontmatter = { enabled = false },
  completion = {
    min_chars = 2,
  },

  picker = {
    name = "fzf-lua",
  },

  callbacks = {
    enter_note = function(_, note)
      vim.o.cc = "80"
    end,
  },

  daily_notes = {
    folder = "notes/dailies",
    date_format = "%Y-%m-%d",
    alias_format = "%A %B %-d, %Y",
    default_tags = { "daily" },
    template = "daily.md",
    workdays_only = false,
  },

  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M:%S",
  },

  -- Optional, customize how note IDs are generated given an optional title.
  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.date("%Y-%m-%d", os.time()) .. "_" .. suffix)
  end,

  note_path_func = function(spec)
    -- This is equivalent to the default behavior.
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md", true)
  end,
})
map("n", "<leader>no", "<cmd>Obsidian <CR>")
map("n", "<leader>nn", "<cmd>Obsidian new<CR>")
map("n", "<leader>nt", "<cmd>Obsidian new_from_template<CR>")
map("n", "<leader>nq", "<cmd>Obsidian open<CR>")
map("n", "<leader>nf", "<cmd>Obsidian quick_switch<CR>")
map("n", "<leader>ng", "<cmd>Obsidian search<CR>")
map("n", "<leader>nL", "<cmd>Obsidian backlinks<CR>")
map("n", "<leader>nd", "<cmd>Obsidian today<CR>")
map("n", "<leader>nD", "<cmd>Obsidian tomorrow<CR>")
map("n", "<leader>ny", "<cmd>Obsidian yesterday<CR>")
map("n", "<leader>nh", "<cmd>Obsidian link<CR>")
map("n", "<leader>nH", "<cmd>Obsidian link_new<CR>")
map("n", "<leader>np", "<cmd>Obsidian paste_img<CR>")
map("n", "<leader>nT", "<cmd>Obsidian template<CR>")
map("n", "<leader>nr", "<cmd>Obsidian rename<CR>")
map("n", "<leader>ns", "<cmd>Obsidian toc<CR>")

-- Neogen:
require('neogen').setup({ snippet_engine = "luasnip" })

-- Codediff:
require("codediff").setup({
  -- Diff view behavior
  diff = {
    ignore_trim_whitespace = true,
    hide_merge_artifacts = false,
    original_position = "left",
    conflict_ours_position = "right",
    conflict_result_position = "bottom", -- "bottom" (default): result below diff panes or "center": result between diff panes (three columns)
    conflict_result_height = 30,         -- Height of result pane in bottom layout (% of total height)
    jump_to_first_change = true,         -- Auto-scroll to first change when opening a diff: false to stay at same line
    highlight_priority = 100,            -- Priority for line-level diff highlights (increase to override LSP highlights)
    compute_moves = false,               -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
  },

  -- Explorer panel configuration
  explorer = {
    focus_on_select = false, -- Jump to modified pane after selecting a file (default: stay in explorer)
    visible_groups = {       -- Which groups to show (can be toggled at runtime)
      staged = true,
      unstaged = true,
      conflicts = true,
    },
  },

  -- History panel configuration (for :CodeDiff history)
  history = {
    position = "bottom",       -- "left" or "bottom" (default: bottom)
    width = 40,                -- Width when position is "left" (columns)
    height = 15,               -- Height when position is "bottom" (lines)
    initial_focus = "history", -- Initial focus: "history", "original", or "modified"
    view_mode = "list",        -- "list" or "tree" for files under commits
  },

  -- Keymaps in diff view
  keymaps = {
    view = {
      quit = "q",                        -- Close diff tab
      toggle_explorer = "<leader>b",     -- Toggle explorer visibility (explorer mode only)
      focus_explorer = "<leader>e",      -- Focus explorer panel (explorer mode only)
      next_hunk = "]c",                  -- Jump to next change
      prev_hunk = "[c",                  -- Jump to previous change
      next_file = "]f",                  -- Next file in explorer/history mode
      prev_file = "[f",                  -- Previous file in explorer/history mode
      diff_get = "do",                   -- Get change from other buffer (like vimdiff)
      diff_put = "dp",                   -- Put change to other buffer (like vimdiff)
      open_in_prev_tab = "gf",           -- Open current buffer in previous tab (or create one before)
      close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
      toggle_stage = "-",                -- Stage/unstage current file (works in explorer and diff buffers)
      stage_hunk = "<leader>hs",         -- Stage hunk under cursor to git index
      unstage_hunk = "<leader>hu",       -- Unstage hunk under cursor from git index
      discard_hunk = "<leader>hr",       -- Discard hunk under cursor (working tree only)
      hunk_textobject = "ih",            -- Textobject for hunk (vih to select, yih to yank, etc.)
      show_help = "g?",                  -- Show floating window with available keymaps
      align_move = "gm",                 -- Temporarily align moved code blocks across panes
      toggle_layout = "t",               -- Toggle between side-by-side and inline layout
    },
    explorer = {
      select = "<CR>",              -- Open diff for selected file
      hover = "K",                  -- Show file diff preview
      refresh = "R",                -- Refresh git status
      toggle_view_mode = "i",       -- Toggle between 'list' and 'tree' views
      stage_all = "S",              -- Stage all files
      unstage_all = "U",            -- Unstage all files
      restore = "X",                -- Discard changes (restore file)
      toggle_changes = "gu",        -- Toggle Changes (unstaged) group visibility
      toggle_staged = "gs",         -- Toggle Staged Changes group visibility
      -- Fold keymaps (Vim-style)
      fold_open = "zo",             -- Open fold (expand current node)
      fold_open_recursive = "zO",   -- Open fold recursively (expand all descendants)
      fold_close = "zc",            -- Close fold (collapse current node)
      fold_close_recursive = "zC",  -- Close fold recursively (collapse all descendants)
      fold_toggle = "za",           -- Toggle fold (expand/collapse current node)
      fold_toggle_recursive = "zA", -- Toggle fold recursively
      fold_open_all = "zR",         -- Open all folds in tree
      fold_close_all = "zM",        -- Close all folds in tree
    },
    history = {
      select = "<CR>",              -- Select commit/file or toggle expand
      toggle_view_mode = "i",       -- Toggle between 'list' and 'tree' views
      refresh = "R",                -- Refresh history (re-fetch commits)
      -- Fold keymaps (Vim-style, apply to directory nodes only)
      fold_open = "zo",             -- Open fold (expand current node)
      fold_open_recursive = "zO",   -- Open fold recursively (expand all descendants)
      fold_close = "zc",            -- Close fold (collapse current node)
      fold_close_recursive = "zC",  -- Close fold recursively (collapse all descendants)
      fold_toggle = "za",           -- Toggle fold (expand/collapse current node)
      fold_toggle_recursive = "zA", -- Toggle fold recursively
      fold_open_all = "zR",         -- Open all folds in tree
      fold_close_all = "zM",        -- Close all folds in tree
    },
    conflict = {
      accept_incoming = "<leader>ct",     -- Accept incoming (theirs/left) change
      accept_current = "<leader>co",      -- Accept current (ours/right) change
      accept_both = "<leader>cb",         -- Accept both changes (incoming first)
      discard = "<leader>cx",             -- Discard both, keep base
      -- Accept all (whole file) - uppercase versions
      accept_all_incoming = "<leader>cT", -- Accept ALL incoming changes
      accept_all_current = "<leader>cO",  -- Accept ALL current changes
      accept_all_both = "<leader>cB",     -- Accept ALL both changes
      discard_all = "<leader>cX",         -- Discard ALL, reset to base
      next_conflict = "]x",               -- Jump to next conflict
      prev_conflict = "[x",               -- Jump to previous conflict
      diffget_incoming = "2do",           -- Get hunk from incoming (left/theirs) buffer
      diffget_current = "3do",            -- Get hunk from current (right/ours) buffer
    },
  },
})

-- render-markdown:
require('render-markdown').setup({
  completions = { lsp = { enabled = true } },
  heading = {
    sign = false,
    position = 'inline',
    width = 'block',
    min_width = 80,
  },
  code = {
    width = 'block',
    min_width = 80,
  },
  dash = { width = 80 },
})
