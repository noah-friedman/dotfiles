require "util.configure_lsp" {
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
