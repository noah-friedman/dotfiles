local configure = require "util.configure"

return {
  {
    "nvim-tree/nvim-web-devicons",
    priority = 601,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "Mofiqul/dracula.nvim",
    },
    priority = 499,
    config = configure "lualine"
  },
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    priority = 498,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = configure "tabby",
  },
  {
    "backdround/tabscope.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "Mofiqul/dracula.nvim",
    config = configure "dracula",
    priority = 500,
  },
  {
    "rcarriga/nvim-notify",
    priority = 101,
    config = configure "notify"
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.4.1",
    priority = 100,
    config = configure "fidget",
  },
  {
    "goolord/alpha-nvim",
    config = configure "alpha",
    priority = 600,
  },
  {
    "lewis6991/gitsigns.nvim",
    priority = 200,
    config = configure "gitsigns",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    init = function()
      vim.ui._input = vim.ui.input
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require "dressing"
        vim.ui.input = vim.ui._input
        vim.ui.input(...)
      end
    end,
    config = configure "dressing",
  },
}
