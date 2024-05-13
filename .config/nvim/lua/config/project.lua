local M = {}

function M.setup()
  require "project_nvim".setup {
    patterns = {
      ".git",
      "Cargo.toml",
      "pyproject.toml",
      "package.json",
      ".project",
    },
    ignore_lsp = {
      "copilot",
      "lua_ls",
      "clangd",
      "taplo",
      "rust-analyzer",
    },
    silent_chdir = false,
    scope_chdir = "tab",
  }
end

return M
