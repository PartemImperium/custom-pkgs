{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
let 
  cfg = config.imperium.programs.sudo;
in
{
  options.imperium.programs.sudo = {
    enable = lib.mkEnableOption "sudo";
    showPassFeedback = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Should sudo render *'s when password is being entered?";
    };
  };

  config = lib.mkIf cfg.enable  {

    security.sudo.extraConfig = lib.mkIf cfg.showPassFeedback "Defaults pwfeedback";
  };
}