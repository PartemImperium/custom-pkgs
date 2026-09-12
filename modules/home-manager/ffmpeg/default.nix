{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.ffmpeg;
in
{
  options.imperium.ffmpeg = {
    enable = mkEnableOption "ffmpeg";

    package = mkPackageOption pkgs "ffmpeg" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
