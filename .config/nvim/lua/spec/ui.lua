return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "Mofiqul/dracula.nvim",
    },
    priority = 600,
    config = function() require "config.lualine".setup() end
  },
  {
    "Mofiqul/dracula.nvim",
    config = function()
      require "dracula".setup {
        colors = {
          menu = "none"
        },
        transparent_bg = true,
        italic_comment = true,
        show_end_of_buffer = true,
        overrides = function(_) return {} end
      }
      vim.cmd.colorscheme "dracula"
    end,
    priority = 500,
  },
  {
    "rcarriga/nvim-notify",
    priority = 300,
    config = function() require "config.notify".setup() end
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.4.1",
    priority = 100,
    config = function() require "config.fidget".setup() end,
  },
  {
    "nvimdev/dashboard-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    config = function() require "config.dashboard".setup() end
  },
  {
    "lewis6991/gitsigns.nvim",
    priority = 200,
    init = function()
      -- This way if the plugin takes a second to load, it doesn't shift the position of the text abruptly
      vim.o.signcolumn = "yes"
    end,
    config = function() require "config.gitsigns".setup() end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
}
