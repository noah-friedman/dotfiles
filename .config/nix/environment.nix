{ isDarwin, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    arduino-cli
    clang
    clang-tools
    curl
    espflash
    espup
    (
      let
        mozilla = rec {
          source = fetchFromGitHub {
            owner = "mozilla";
            repo = "nixpkgs-mozilla";
            rev = "534ee26d3dbcbb9da3766c556638b9bcc3627871";
            sha256 = "oh7GSCjBGHpxaU8/gejT55mlvI3qoKObXgqyn1XR7SA=";
          };
          overlay = callPackage "${source.out}/package-set.nix" {};
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
    git
    nix-output-monitor
    ripgrep
    rustup
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
