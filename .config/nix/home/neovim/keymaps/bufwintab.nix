{ lib, mode, modifier, ... }: with lib; ([
  {
    action = "<Cmd>tabnew<CR>";
    key = "<${modifier}-t>";
    inherit mode;
  }
  {
    action = "<Cmd>tabnew +terminal<CR>i";
    key = "<${modifier}-T>";
    inherit mode;
  }
  {
    action = "<Cmd>BufferClose<CR>";
    key = "<${modifier}-w>";
    inherit mode;
  }
  {
    action = "<Cmd>BufferClose!<CR>";
    key = "<${modifier}-W>";
    inherit mode;
  }
  (map ({ action, key }: map (x: {
    action = action x; 
    key = key x;
  }) (map (x: toString x) (range 0 9))) [
    { action = x: "BufferGoto${x}"; key = x: "<${modifier}-${x}>"; }
    { action = x: "${x}tabnext"; key = x: "<A-${x}>"; }
  ])
] ++ (let
  controls = let
    arrows = ["Left" "Right"];
    suffixes = ["Previous" "Next"];
  in {
    ${modifier} = {
      inherit arrows;
      prefix = "Buffer";
      inherit suffixes;
    };
    A = {
      arrows = ["Up" "Down" "Left" "Right"];
      prefix = "wincmd ";
      suffixes = ["W" "w" "W" "w"];
    };
    S = {
      inherit arrows;
      prefix = "tab";
      suffixes = map (x: toLower x) suffixes;
    };
  };
in (mapAttrsToList (modifier: { prefix, suffixes, arrows }:
  (zipListsWith (suffix: arrow: { 
    action = "<Cmd>${prefix}${suffix}<CR>";
    key = "<${modifier}-${arrow}>";
  inherit mode;
  }) suffixes arrows)
) controls)))
