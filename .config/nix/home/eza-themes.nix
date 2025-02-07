{ pkgs, ... }: {
  home.file."${
    if pkgs.stdenv.isDarwin
    then "Library/Application Support"
    else ".config"
  }/eza/theme.yml".source = "${(builtins.fetchTarball
                   "https://github.com/eza-community/eza-themes/archive/main.tar.gz")
               }/themes/dracula.yml";
}
