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
    users.defaultUserShell = lib.mkDefault pkgs.zsh;
  };
}