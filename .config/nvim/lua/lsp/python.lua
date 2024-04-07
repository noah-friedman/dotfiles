require "util.configure_lsp" ("pylsp", "*.py", {
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
            F401 = "W"
          },
        },
      }
    }
  }
})
