{ lib, pkgs }:
{
  program = {
    enable = true;
    extraOptions = [
      "-l"
      "--header"
    ];
    git = true;
    icons = "always";
  };

  aliases = let
    darwin = if pkgs.stdenv.isDarwin then [
      ".DS_Store"
    ] else [];

    ignore = lib.strings.concatStringsSep "|" ([
      "build"

      "Cargo.lock"
      "target"

      "node_modules"

      ".mypy_cache"
      "__pycache__"
      ".ropeproject"
      ".venv"
    ] ++ darwin);

    tree = prefix: "${prefix} --tree --level 5";
  in {
    z = ''eza $([ "$(dirname $PWD)" != "$(dirname $HOME)" ] && echo -n " -a ") --git-ignore --ignore-glob="${ignore}"'';
    za = "z -a";
    zz = tree "z";
    zza = tree "za";
  };
}
