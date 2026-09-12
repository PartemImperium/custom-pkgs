{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.yt-dlp;
in
{
  options.imperium.yt-dlp = {
    enable = mkEnableOption "yt-dlp";

    package = mkPackageOption pkgs "yt-dlp" {};

  };
  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;

      package = cfg.package;
    };
  };
}
#TODO: once unstable link is working change package to use unstable. yt-dlp is in a constant battle to stay working.... Having a newer release is very helpful.