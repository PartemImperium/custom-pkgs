{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
with lib;
{
  config = mkIf (pkgs.stdenv.isLinux && host.isDesktop) {
    services.printing.enable = lib.mkDefault true;
  };
}