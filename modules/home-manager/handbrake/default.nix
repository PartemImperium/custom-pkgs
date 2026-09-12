{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.handbrake;
in
{
  options.imperium.handbrake = {
    enable = mkEnableOption "handbrake";

    package = mkPackageOption pkgs "handbrake" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
