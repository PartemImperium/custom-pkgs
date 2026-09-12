{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.picard;
in
{
  options.imperium.picard = {
    enable = mkEnableOption "picard";

    package = mkPackageOption pkgs "picard" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
