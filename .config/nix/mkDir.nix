{ args ? {}, extra ? [], filter ? [".gitkeep" "default.nix"], lib, path }: with builtins; let
  list = (map (x: import (path + "/${x}") args) (attrNames (removeAttrs (readDir path) filter))) ++
            extra;
  r = {
    config = if isList (elemAt list 0)
             then lib.flatten list
             else lib.mkMerge (map (x: removeAttrs x ["imports"]) list);
    imports = foldl' (a: b: if b ? imports
                            then a ++ b.imports
                            else a) [] list;
  };
in if (length r.imports) == 0
   then r.config
   else r
