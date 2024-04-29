require "util.configure".lsp {
  lsp = "yamlls",
  pattern = { "*.yml", "*.yaml" },
  config = {
    settings = {
      yaml = {
        schemaStore = {
          enable = true,
        },
      },
    },
  }
}
