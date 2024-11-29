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
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    lazy = true,
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
    cmd = "CopilotChat",
    config = configure "copilot.chat"
  },
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    build = "./build || .\\build",
    config = true,
  }
}
