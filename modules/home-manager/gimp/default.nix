{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.gimp;
in
{
  options.imperium.gimp = {
    enable = mkEnableOption "gimp";

    package = mkPackageOption pkgs "gimp" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
