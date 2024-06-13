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
    event = "FileType python",
    cmd = {
      "VenvSelect",
      "VenvSelectCached",
      "VenvSelectCurrent",
    },
    config = configure "venv",
  },
}
