{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.makemkv;
in
{
  options.imperium.makemkv = {
    enable = mkEnableOption "makemkv";

    package = mkPackageOption pkgs "makemkv" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
