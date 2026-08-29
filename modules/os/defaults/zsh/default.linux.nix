{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
with lib;
{
  config = mkIf pkgs.stdenv.isLinux {
    users.defaultUserShell = lib.mkOverride 900 pkgs.zsh;#TODO: Make a mkOverride helper that defaults the val to 900 to be a override for normal default but still overrideable by normal set.
  };
}