require "util.configure".lsp {
  lsp = "jdtls",
  pattern = "*.java",
  config = {
    cmd = { vim.fn.stdpath "data" .. "/lsp/jdtls/bin/jdtls" },
  }
}
--[[
require "util.configure".lsp {
  lsp = "java_language_server",
  pattern = { "*.java" },
  config = {
    cmd = { vim.fn.stdpath "data" .. "/lsp/java-language-server/dist/lang_server_mac.sh" },
    single_file_support = true,
  },
}
]]
