{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.git;
in
{
  options.imperium.git = {
    enable = mkEnableOption "git";

    package = mkPackageOption pkgs "git" {};

  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = cfg.package;
    };
  };
}
