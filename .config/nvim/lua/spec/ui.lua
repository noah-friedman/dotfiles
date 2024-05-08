local configure = require "util.configure"

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "Mofiqul/dracula.nvim",
    },
    priority = 500,
    config = configure "lualine"
  },
  {
    "nanozuki/tabby.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = configure "tabby",
    priorty = 501,
  },
  {
    "backdround/tabscope.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "Mofiqul/dracula.nvim",
    config = configure "dracula",
    priority = 1000,
  },
  {
    "rcarriga/nvim-notify",
    config = configure "notify",
    event = "VeryLazy",
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.4.1",
    event = "User NotCopilot",
    config = configure "fidget",
  },
  {
    "goolord/alpha-nvim",
    config = configure "alpha",
    priority = 999,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "tpope/vim-fugitive",
    },
    config = configure "gitsigns",
    event = "User FileOpened",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "User FileOpened",
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    config = configure "dressing",
    lazy = true,
  },
}
