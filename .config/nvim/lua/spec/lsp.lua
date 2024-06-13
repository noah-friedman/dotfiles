local configure = require "util.configure"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        config = configure "copilot",
      },
    },
    lazy = true,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      {
        "dcampos/nvim-snippy",
        dependencies = {
          "dcampos/cmp-snippy",
          "honza/vim-snippets",
        },
      },
      {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
          {
            "windwp/nvim-ts-autotag",
            config = configure "autotag",
          },
          {
            "jmbuhr/otter.nvim",
            config = configure "otter"
          }
        },
        config = configure "treesitter",
      },
    },
    lazy = true,
    event = "CmdlineEnter",
    config = configure "cmp",
  },

  -- Format on save through LSP
  {
    "lukas-reineke/lsp-format.nvim",
    lazy = true,
  },

  -- JSON/YAML schemas
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },

  -- Extension to LuaLS that makes it aware of Neovim runtime files
  {
    "folke/neodev.nvim",
    lazy = true,
  },

  -- Rust LSP and other goodies
  {
    "mrcjkb/rustaceanvim",
    dependencies = {
      "rust-lang/rust.vim",
      {
        "Saecki/crates.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
    },
    -- Configuration found in `lsp/rust.lua` because we don't use `lspconfig` for this one
    ft = "rust",
  },
  {
    "Saecki/crates.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",

      -- Loads `rustaceanvim` for the non-LSP features it provides
      {
        "mrcjkb/rustaceanvim",
      }
    },
    event = "BufRead *Cargo.toml",
    config = true
  },
}
