{ path, config, ... } @ inputs:
let
  local = "${config.xdg.configHome}/local/home-manager/zsh/${path}";
in if builtins.pathExists local && builtins.readFileType local == "directory"
   then import ./recursive.nix (inputs // { path = local; })
   else []
