{ lib, ... } @ inputs:
lib.attrsets.mapAttrsToList (_: value: value) (import ../recursive.nix inputs)
