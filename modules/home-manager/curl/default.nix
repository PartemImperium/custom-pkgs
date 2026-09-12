{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.curl;
in
{
  options.imperium.curl = {
    enable = mkEnableOption "curl";

    package = mkPackageOption pkgs "curl" {};

  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
