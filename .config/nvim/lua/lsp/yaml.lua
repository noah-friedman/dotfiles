require "util.configure".lsp {
  lsp = "yamlls",
  pattern = { "*.yml", "*.yaml" },
  config = function()
    return {
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require "schemastore".yaml.schemas(),
        },
      },
    }
  end,
}
