{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.zsh;
in
{
  options.imperium.zsh = {
    enable = mkEnableOption "zsh";

    package = mkPackageOption pkgs "zsh" {};

  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      package = cfg.package;
    };
  };
}
