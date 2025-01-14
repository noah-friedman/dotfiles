{ isDarwin, pkgs, ... }: let
  name = "speelbarrow";
in {
  imports = [(if isDarwin
             then <home-manager/nix-darwin>
             else <home-manager/nixos>)];

  users.users.${name} = {
    inherit name;
    home = let
      prefix = if isDarwin then "Users" else "home";
    in "/${prefix}/${name}";
  };
  home-manager.users.${name} = import ./home;
}
