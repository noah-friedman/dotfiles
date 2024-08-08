local configure = require "util.configure"

return {
  {
    "ahmedkhalf/project.nvim",
    config = configure "project",
    event = "VeryLazy",
  },
  {
    "tiagovla/scope.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    main = "venv-selector",
    config = true,
  },
}
