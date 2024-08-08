require "util.configure".lsp {
  lsp = "sourcekit",
  pattern = "*.swift",
  config = {
    root_dir = require "lspconfig.util".root_pattern("Package.swift", "buildServer.json", "*.xcodeproj",
                                                     "*.xcworkspace", "compile_commands.json", ".git"),
  }
}
