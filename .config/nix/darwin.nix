{ casks, lib, isDarwin, pkgs, ... }: if isDarwin then {
  environment.systemPackages = [
    casks.docker
  ];
  security.pam.enableSudoTouchIdAuth = true;
} else {}
