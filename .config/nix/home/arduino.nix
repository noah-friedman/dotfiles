{ pkgs, ... }: {
  home.packages = with pkgs; [
    arduino-cli
  ];
  programs.nixvim.plugins.lsp.servers.arduino_language_server = {
    enable = true;
    extraOptions = {
      capabilities = rec {
        textDocument.semanticTokens.__raw = "vim.NIL";
        workspace = textDocument;
      };
      cmd.__raw = ''(function()
        Clangd = vim.system({ 'which', 'clangd' }, { text = true }):wait().stdout:gsub("\n", "")
        return {
          "arduino-language-server",
          "-clangd",
          Clangd,
          "-cli-config",
          -- This needs to be symlinked manually
          vim.env.HOME .. "/.arduino.yaml",
          "-format-conf-path",
          -- This too
          vim.env.HOME .. "/.clang-format",
          "-jobs",
          tostring(#vim.uv.cpu_info())
        }
      end)()'';
    };
    onAttach.function = ''Client = vim.lsp.get_client_by_id(client.id)'';
    package = pkgs.buildGoModule rec {
      name = src.repo;
      src = pkgs.fetchFromGitHub {
        owner = "speelbarrow";
        repo = "arduino-language-server";
        rev = "ee17a87081a38ebcd0ca3dc0fb2b1f040811925e";
        sha256 = "3XwfU9qPQiLg95x7xI08GLn/Ln6b05N2YAM4uwJ8QT4=";
      };
      vendorHash = "sha256-Mu9W92f8ZEaTfJ8YkhKpOvFMB/QzqoxfWkSGWlU/yVM=";
    };
  };
}
