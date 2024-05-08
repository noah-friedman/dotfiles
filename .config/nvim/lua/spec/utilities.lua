local configure = require "util.configure"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    config = configure "treesitter",
  },
  {
    "ahmedkhalf/project.nvim",
    config = configure "project",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    ft = { "html", "javascriptreact", "typescriptreact", "xml", "svg" },
  },
  {
    "linux-cultist/venv-selector.nvim",
    event = "FileType python",
    cmd = {
      "VenvSelect",
      "VenvSelectCached",
      "VenvSelectCurrent",
    },
    config = configure "venv",
  },
}
