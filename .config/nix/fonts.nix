{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerdfonts
  ];
  nixpkgs.overlays = [
    (final: prev: {
      nerdfonts = prev.nerdfonts.override {
        fonts = ["JetBrainsMono"];
      };
    })
  ];
}
