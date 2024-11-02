require "util.configure".lsp {
  lsp = "arduino_language_server",
  pattern = { "*.ino", "*.hpp" },
  derive_filetypes = false,
  config = {
    cmd = {
      "arduino-language-server",
      "-cli-config",
      -- Make a symlink to the arduino-cli config file in your home directory in order to maintain
      -- platform agnosticism
      vim.env.HOME .. "/.arduino.yaml",

      "-format-conf-path",
      -- Make a symlink to the .clang-format file in your home directory in order to maintain
      -- platform agnosticism
      vim.env.HOME .. "/Library/Preferences/clangd/.clang-format"
    },
  },
  -- Don't override capabilities (using `util.configure.lsp`), as this LSP doesn't support them
  capabilities = false,
}
