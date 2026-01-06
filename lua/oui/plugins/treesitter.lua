local old = {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "windwp/nvim-ts-autotag" },
    },
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup({ -- enable syntax highlighting
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "latex" },
        },
        -- enable indentation
        indent = { enable = true, disable = { "python" } },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<M-space>",
            node_decremental = "<bs>",
          },

          textobjects = {
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]m"] = { query = "@function.outer", desc = "Next function" },
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
                ["]a"] = { query = "@parameter.inner", desc = "Next parameter" },
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
                ["]A"] = "@parameter.inner",
              },
              goto_previous_start = {
                ["[m"] = { query = "@function.outer", desc = "Previous function" },
                ["[["] = { query = "@class.outer", desc = "Previous class start" },
                ["[a"] = { query = "@parameter.inner", desc = "Previous parameter" },
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
                ["[A"] = "@parameter.inner",
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ["<leader>a"] = "@parameter.inner",
              },
              swap_previous = {
                ["<leader>A"] = "@parameter.inner",
              },
            },
          },

          -- ensure these language parsers are installed
          ensure_installed = {
            "c",
            "cpp",
            "java",
            "python",
            "javascript",
            "typescript",
            "html",
            "css",
            "lua",
            "tsx",
            "json",
            "yaml",
            "toml",
            "kdl",
            "bash",
            "vim",
            "dockerfile",
            "make",
            "gitignore",
            "markdown",
            "markdown_inline",
            "latex",
            "bibtex",
          },
        },
      })
    end,
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local ts = require('nvim-treesitter')

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
        "vue",
        "html",
        "css",
        "lua",
        "tsx",
        "json",
        "yaml",
        "toml",
        "bash",
        "vim",
        "dockerfile",
        "make",
        "cmake",
        "gitignore",
        "markdown",
        "markdown_inline",
        "latex",
        "bibtex",
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      -- put your config here
      vim.keymap.set("n", "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
      end)
      vim.keymap.set("n", "<leader>A", function()
        require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
      end)
    end,
  }
}
