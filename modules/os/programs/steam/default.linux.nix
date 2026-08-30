{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
let 
  cfg = config.imperium.programs.steam;
{
  config = lib.mkIf (cfg.enable && pkgs.stdenv.isLinux && host.isDesktop) {
    programs.steam = {
      enable = true;
      extest.enable = true; # extest allows steam controller to not prompt for remote access every time you use it...
    };
    hardware.steam-hardware.enable = true;

    systemd.user.services.steam-background = lib.mkIf cfg.startOnLogin {
      enable = true;
      description = "Start Steam in background";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${config.programs.steam.package}/bin/steam -silent";
        Restart = "always";
      };
    };
  };
}