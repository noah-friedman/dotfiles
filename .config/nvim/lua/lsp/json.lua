require "util.configure".lsp {
  lsp = "jsonls",
  pattern = "*.json",
  config = function()
    return {
      settings = {
        json = {
          schemas = require "schemastore".json.schemas(),
          validate = {
            enable = true,
          },
        },
      },
    }
  end,
}
