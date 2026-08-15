{ 
  pkgs,
  lib,
  stdenv,
  config,
  ...
}:
with lib;
let cfg = config.imperium.defaults.localization; 
in
{
  options.imperium.defaults.localization = {
    locale = mkOption {
      types = types.string;
      default = "en_US.UTF-8";
      description = "Locale to be applied to all locale's with mkDefault.";
    };
  };

  imports = optional stdenv.isLinux ./default.linux.nix 
        ++ optional stdenv.isDarwin ./default.darwin.nix;
}