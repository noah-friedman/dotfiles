{ args ? {}, filter ? ["default.nix"], lib, path }: with builtins; let
  list = map (x: import (path + "/${x}") args) (attrNames (removeAttrs (readDir path) filter));
in {
  config = lib.mkMerge (map (x: removeAttrs x ["imports"]) list);
  imports = foldl' (a: b: if b ? imports
                          then a ++ b.imports
                          else a) [] list;
}
