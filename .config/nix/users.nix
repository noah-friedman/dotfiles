{ isDarwin, ... }: let
  user = import ./user.nix isDarwin;
  inherit (user) name;
in {
  imports = [(if isDarwin
             then <home-manager/nix-darwin>
             else <home-manager/nixos>)];

  users.users.${name} = user;
  home-manager.users.${name} = import ./home;
}
