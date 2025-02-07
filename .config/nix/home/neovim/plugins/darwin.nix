{ lib, pkgs, ... }: {
  imports = lib.optionals pkgs.stdenv.isDarwin [(pkgs.vimUtils.buildVimPlugin {
    name = "vim-plist";
    src = builtins.fetchTarball {
      url = "https://github.com/darfink/vim-plist/archive/master.tar.gz";
    };
  })];
}
