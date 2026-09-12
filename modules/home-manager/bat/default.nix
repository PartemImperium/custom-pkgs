{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.bat;
in
{
  options.imperium.bat = {
    enable = mkEnableOption "bat";

    package = mkPackageOption pkgs "bat" {};

  };
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;

      package = cfg.package;
    };
  };
}
