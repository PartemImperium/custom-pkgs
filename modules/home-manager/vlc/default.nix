{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.vlc;
in
{
  options.imperium.vlc = {
    enable = mkEnableOption "vlc";

    package = mkPackageOption pkgs "vlc" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
