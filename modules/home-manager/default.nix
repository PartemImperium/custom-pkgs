{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = 
  [
    ./glow/default.nix
    ./starship/default.nix
    ./terminal-fetch/default.nix
  ];
}