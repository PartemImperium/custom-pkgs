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
      defaultLocale = lib.mkDefault builtins.trace cfg.locale cfg.locale;

      extraLocaleSettings = {
        C_ADDRESS = lib.mkDefault cfg.locale;
        C_IDENTIFICATION = lib.mkDefault cfg.locale;
        C_MEASUREMENT = lib.mkDefault cfg.locale;
        C_MONETARY = lib.mkDefault cfg.locale;
        C_NAME = lib.mkDefault cfg.locale;
        C_NUMERIC = lib.mkDefault cfg.locale;
        C_PAPER = lib.mkDefault cfg.locale;
        C_TELEPHONE = lib.mkDefault cfg.locale;
        C_TIME = lib.mkDefault cfg.locale;
      };
    };
  };
}