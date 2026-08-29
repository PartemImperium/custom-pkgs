{ 
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config  = mkIf pkgs.stdenv.isLinux {

    networking = {
      useDHCP = mkDefault true;
      networkmanager.enable = mkDefault true;
    };
  };
}