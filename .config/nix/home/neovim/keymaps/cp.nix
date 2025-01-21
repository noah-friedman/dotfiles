{ modifier, ... }: let
  paste = "<${modifier}-v>";
in [
  {
    action = ''"*y'';
    key = "<${modifier}-c>";
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
