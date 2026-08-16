{ 
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let cfg = config.imperium.defaults.localization; 
in
{
  config  = mkIf pkgs.stdenv.isLinux {
    i18n = {
      defaultLocale = mkDefault builtins.trace cfg.locale cfg.locale;

      extraLocaleSettings = {
        C_ADDRESS = mkDefault cfg.locale;
        C_IDENTIFICATION = mkDefault cfg.locale;
        C_MEASUREMENT = mkDefault cfg.locale;
        C_MONETARY = mkDefault cfg.locale;
        C_NAME = mkDefault cfg.locale;
        C_NUMERIC = mkDefault cfg.locale;
        C_PAPER = mkDefault cfg.locale;
        C_TELEPHONE = mkDefault cfg.locale;
        C_TIME = mkDefault cfg.locale;
      };
    };
  };
}