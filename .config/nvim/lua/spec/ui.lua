local configure = require "util.configure"

return {
  {
    "nvim-lualine/lualine.nvim",
    priority = 600,
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
    "nvimdev/dashboard-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    config = configure "dashboard",
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
