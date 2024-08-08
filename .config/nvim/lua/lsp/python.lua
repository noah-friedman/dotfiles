require "util.configure".lsp {
  lsp = "pylsp",
  pattern = "*.py",
  config = {
    root_dir = function(fname)
      local root_files = {
        ".venv",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
      }

      local util = require "lspconfig.util"
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    settings = {
      pylsp = {
        plugins = {
          rope_autoimport = {
            enabled = true
          },
          ruff = {
            enabled = true,
            formatEnabled = true,
            lineLength = 120,
            select = {
              "E",
              "F",
              "W",
            },
            ignore = {
              "F403",
              "F405",
            },
            severities = {
              F401 = "W",
              F841 = "W",
            },
          },
        }
      }
    }
  }
}
