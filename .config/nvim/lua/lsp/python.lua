require "util.configure".lsp {
  lsp = "pylsp",
  pattern = "*.py",
  config = {
    settings = {
      pylsp = {
        plugins = {
          rope_autoimport = {
            enabled = true
          },
          ruff = {
            enabled = true,
            lineLength = 120,
            select = {
              "E",
              "F",
              "W",
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
