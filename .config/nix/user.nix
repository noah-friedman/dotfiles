isDarwin: rec {
  name = "speelbarrow";
  home = let
    prefix = if isDarwin then "Users" else "home";
  in "/${prefix}/${name}";
}
