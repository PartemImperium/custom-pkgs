{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.glow;
in
{
  options.imperium.glow = {
    enable = mkEnableOption "glow";

    package = mkPackageOption pkgs "glow" { };

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
