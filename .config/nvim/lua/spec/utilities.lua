local configure = require "util.configure"

return {
  {
    "ahmedkhalf/project.nvim",
    config = configure "project",
    priority = 450,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        config = configure "treesitter",
      },
    },
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
