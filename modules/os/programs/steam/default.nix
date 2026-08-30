{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  options.imperium.programs.steam = {
    enable = lib.mkEnableOption "steam";
    startOnLogin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Should Steam be started on session start";
    };
  };

  imports = [
    ./default.linux.nix 
  ]; 
}