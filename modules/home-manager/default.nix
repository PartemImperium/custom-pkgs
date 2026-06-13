{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = 
  [
    ./starship/default.nix
  ];
}