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
    ./terminal-fetch/default.nix
  ];
}