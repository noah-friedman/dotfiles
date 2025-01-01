inputs:
rec {
  ret = { path, lib, ... }: lib.attrsets.mapAttrs (name: value: {
    "regular" = if (name == "default.nix") || (! lib.strings.hasSuffix ".nix" name) then [] else let 
      p = "${path}/${name}";
    in import p inputs;
    "directory" = ret (inputs // { path = "${path}/${name}"; });
    "symlink" = lib.warn "recursive: skipping '${name}' - unsupported filetype ${value}" [];
    "unknown" = lib.warn "recursive: skipping '${name}' - unsupported filetype ${value}" [];
  }."${value}") (builtins.readDir path);
}.ret inputs
