{ isDarwin, ... }: if !isDarwin then {
  virtualisation.docker.enable = true;
} else {}
