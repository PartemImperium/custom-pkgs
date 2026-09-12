{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.alacritty;
in
{
  options.imperium.alacritty = {
    enable = mkEnableOption "alacritty";

    package = mkPackageOption pkgs "alacritty" {};

  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = cfg.package;
    }
  };
}
