{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
with lib;
{# Enable CUPS to print documents.
  config = mkIf (pkgs.stdenv.isLinux && host.isDesktop) {
    services.printing.enable = lib.mkDefault true;
  };
}