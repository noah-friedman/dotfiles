-- `go install github.com/arduino/arduino-language-server@latest`
-- (Requires `clangd` and `arduino-cli`)
require "util.configure_lsp" {
  lsp = "arduino_language_server", 
  pattern = "*.ino", 
  config = {
    cmd = {
      "arduino-language-server",
      "-cli-config",
      -- Make a symlink to the arduino-cli config file in your home directory in order to maintain platform agnosticism
      vim.fn.expand "~/.arduino.yaml"
    },
  },
  -- Don't override capabilities (using `util.configure_lsp`), as this LSP doesn't support them
  capabilities = false,
}
