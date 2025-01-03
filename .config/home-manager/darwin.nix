{ cask, pkgs }: {
  packages = (with cask; [
  ]) ++ (with pkgs; [
    zoom-us
  ]);
}
