local configure = require "util.configure"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = function()
      local install = require "nvim-treesitter.install"
      for _, lang in ipairs { "html", "tsx", "xml" } do
        if not require "nvim-treesitter.parsers".has_parser(lang) then
          install.commands.TSInstall.run(lang)
        end
        install.update()
      end
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "html", "javascriptreact", "typescriptreact", "xml", "svg" },
    config = configure "autotag",
  },
  {
    "ahmedkhalf/project.nvim",
    config = configure "project",
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
