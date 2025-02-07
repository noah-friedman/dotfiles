{ lib, isDarwin, pkgs, ... }: {
  environment = {
    extraInit = lib.concatLines (import ../mkDir.nix {
      args = { inherit pkgs; };
      inherit lib;
      path = ./init;
    });

    # Required for home-manager.programs.zsh.enableCompletion to work properly.
    pathsToLink = ["/share/zsh"];

    shellAliases = {
      rebuild = let
        command = if isDarwin
                  then "darwin-rebuild"
                  else if builtins.pathExists "/etc/nixos"
                  then "nixos-rebuild"
                  else "home-manager";
        cores = if isDarwin
                then "sysctl -n hw.ncpu"
                else "nproc --all";
      in "${command} switch --cores $(${cores}) --max-jobs $(${cores}) |& nom";
      eza = "command eza -l --header --git --icons";
      z = let
        ignore = builtins.concatStringsSep "|" ([
          ".git"

          "build"
          "out"

          "Cargo.lock"
          "target"

          "node_modules"

          ".mypy_cache"
          "__pycache__"
          ".ropeproject"
          ".venv"
        ] ++ lib.optionals isDarwin [".DS_Store"]);
      in ''eza $([ "$(dirname $PWD)" != "$(dirname $HOME)" ] && echo -n " -a ") \
            --git-ignore \
            --ignore-glob="${ignore}"'';
      za = "eza -a";
      zz = "z --tree";
      zza = "za --tree";
    };

    systemPackages = with pkgs; [
      arduino-cli
      avrdude
      clang
      clang-tools
      curl
      docker
      espflash
      espup
      (
        let
          mozilla = rec {
            source = builtins.fetchTarball {
              url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
            };
            overlay = callPackage "${source}/package-set.nix" {};
          };
          rust = (mozilla.overlay.rustChannelOf { 
            channel = "stable";
            date = "2025-01-09"; # 1.84.0
          }).rust;
        in (makeRustPlatform {
          cargo = rust;
          rustc = rust // { inherit (rustc) badTargetPlatforms targetPlatforms; }; 
        }).buildRustPackage rec {
        pname = "esp-generate";
        version = "v0.2.2";
        cargoHash = "sha256-KHrgUqZ4UyI3aWlEKJ3AMvAenDaZmwN+em3ywOfBsaM=";
        src = fetchFromGitHub {
          owner = "esp-rs";
          repo = pname;
          rev = version;
          hash = "sha256-qDlEI9cav2RSsYinIlW4VqmCtUW+vAgFJOE2miFAVVo=";
        };
      })
      eza
      git
      gnumake
      nix-output-monitor
      python3
      ripgrep
      rustup
      wget
      wireguard-tools
      yadm
    ];
  };
}
