{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.imperium.terminal-fetch;
in
{
  options.imperium.terminal-fetch = {
    enable = mkEnableOption "terminal-fetch";

    package = mkPackageOption pkgs "fastfetch" {};

  };
#TODO: Add other shells 
  config = mkIf cfg.enable {
    programs.zsh.initContent = pkgs.lib.mkOrder 9000 ''
    #terminal-fetch module
    ${lib.getExe cfg.package}
    '';

    home.packages = [
      cfg.package
    ];
  };
}