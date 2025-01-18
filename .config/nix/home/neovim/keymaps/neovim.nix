{ pkgs, ... }: let
  paste = if pkgs.stdenv.isDarwin then "<D-v>" else "<C-v>";
in [ 
  {
    action = ''"*y'';
    key = if pkgs.stdenv.isDarwin then "<D-c>" else "<C-c>";
    mode = "v";
  }

  {
    action = ''"*p'';
    key = paste;
    mode = ["n" "v"];
  }
  {
    action = ''<Esc>"*pa'';
    key = paste;
    mode = "i";
  }
]
