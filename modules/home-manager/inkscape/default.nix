{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.inkscape;
in
{
  options.imperium.inkscape = {
    enable = mkEnableOption "inkscape";

    package = mkPackageOption pkgs "inkscape" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
