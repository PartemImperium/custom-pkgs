{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.flac;
in
{
  options.imperium.flac = {
    enable = mkEnableOption "flac";

    package = mkPackageOption pkgs "flac" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
