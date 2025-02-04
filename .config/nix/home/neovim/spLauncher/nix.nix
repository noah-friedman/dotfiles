{ pkgs, ... }: {
  base = if pkgs.stdenv.isDarwin 
         then "darwin-rebuild"
         else if builtins.pathExists /etc/nixos
         then "nixos-rebuild"
         else "home-manager";
  run = "switch |& nom";
  debug = "switch --show-trace |& nom";
  build = "build |& nom";
  test = "check |& nom";
}
