local util = require "lspconfig.util"
require "util.configure".lsp {
  lsp = "clangd",
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  config = {
    capabilities = {
      offsetEncoding = "utf-8"
    },
    root_dir = function(fname)
      local root_files = {
        "CMakeLists.txt",
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
      }
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
  }
}
