{ lib, isDarwin, pkgs, ... }: if isDarwin then {
  security.pam.enableSudoTouchIdAuth = true;
} else {}
