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
    config = configure "lualine"
  },
  {
    "Mofiqul/dracula.nvim",
    config = configure "dracula",
    priority = 500,
  },
  {
    "rcarriga/nvim-notify",
    priority = 300,
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
    init = function()
      -- This way if the plugin takes a second to load, it doesn't shift the position of the text abruptly
      vim.o.signcolumn = "yes"
    end,
    config = configure "gitsigns",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
}
