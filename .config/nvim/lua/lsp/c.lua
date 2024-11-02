local util = require "lspconfig.util"
require "util.configure".lsp {
  lsp = "clangd",
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  formatter = false,
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
      return vim.fs.root(fname, unpack(root_files)) or util.find_git_ancestor(fname) or vim.fn.expand "%:p:h"
    end,
  },
}
