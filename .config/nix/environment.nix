{ isDarwin, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clang-tools
    curl
    git
    nix-output-monitor
    ripgrep
    wget
    wireguard-tools
    yadm
  ];

  environment.shellAliases = {
    rebuild = let
      command = if isDarwin
                then "darwin"
                else "nixos";
      cores = if isDarwin
              then "sysctl -n hw.ncpu"
              else "nproc --all";
    in "${command}-rebuild switch --cores $(${cores}) --max-jobs $(${cores}) |& nom";
  };
}
