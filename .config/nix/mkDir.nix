{ args ? {}, filter ? ["default.nix"], lib, path }: with builtins; let
  list = map (x: import (path + "/${x}") args) (attrNames (removeAttrs (readDir path) filter));
in {
  config = foldl' (a: b: lib.recursiveUpdate a b) {} (map (x: removeAttrs x ["imports"]) list);
  imports = foldl' (a: b: if b ? imports
                          then a ++ b.imports
                          else a) [] list;
}
