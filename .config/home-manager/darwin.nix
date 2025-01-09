{ cask, pkgs }: {
  packages = (with cask; [
    
  ]) ++ (with pkgs; [
    zoom-us
    yt-dlp
  ]);
}
