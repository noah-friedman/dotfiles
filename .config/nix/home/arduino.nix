{ pkgs, ... }: {
  home.packages = with pkgs; [
    arduino-cli
  ];
  programs.nixvim.plugins.lsp.servers.arduino_language_server = {
    enable = true;
    extraOptions = {
      capabilties = rec {
        textDocument.semanticTokens.__raw = "vim.NIL";
        workspace = textDocument;
      };
      cmd.__raw = ''{
        "arduino-language-server",
        "-clangd",
        vim.system({ 'which', 'clangd' }, { text = true }):wait().stdout:gsub("\n", ""),
        "-cli-config",
        -- This needs to be symlinked manually
        vim.env.HOME .. "/.arduino.yaml",
        "-format-conf-path",
        -- This too
        vim.env.HOME .. "/.clang-format",
        "-jobs",
        tostring(#vim.uv.cpu_info())
      }'';
    };
    onAttach.function = ''client.capabilities.textDocument.semanticTokens = vim.NIL
                          client.capabilities.workspace.semanticTokens = vim.NIL
                          Client = client'';
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
