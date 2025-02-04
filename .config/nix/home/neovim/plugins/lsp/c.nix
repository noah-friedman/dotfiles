{ config, pkgs, ... }: {
  clangd.enable = true;

  arduino_language_server = {
    enable = true;
    extraOptions = {
      capabilities = rec {
        textDocument.semanticTokens.__raw = "vim.NIL";
        workspace = textDocument;
      };
      cmd = let
        config = if pkgs.stdenv.isDarwin then "Library/Arduino15" else ".arduino15";
      in [
        "arduino-language-server"
        "-cli-config"
        { __raw = "vim.env.HOME .. '/${config}/arduino-cli.yaml'"; }
        "-format-conf-path"
        { __raw = "vim.env.HOME .. '/.clang-format'"; }
        "-jobs"
        { __raw = "tostring(#vim.uv.cpu_info())"; }
      ]; /*''{
        "arduino-language-server",
        "-cli-config",
        vim.env.HOME .. "/${config}/arduino-cli.yaml",
        "-format-conf-path",
        vim.env.HOME .. "/.clang-format",
        "-jobs",
        tostring(#vim.uv.cpu_info())
      }'';*/
    };
    filetypes = ["arduino"];
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
