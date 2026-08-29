{
  lib,
  ...
}:
let 
  hostDir = builtins.readDir ./hosts;

  hostFiles = lib.filterAttrs (n: v: v == "regular" && lib.strings.hasSuffix ".nix" n) hostDir;
  
  final = lib.attrsets.mapAttrs' (n: v: { name = lib.strings.removeSuffix ".nix" n; value = import (lib.path.append ./hosts n); }) hostFiles;
in #nix-instantiate --eval --strict test.nix  
  final