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
  options.imperium.defaults.localization = {
    locale = mkOption {
      types = types.string;
      default = "en_US.UTF-8";
      description = "Locale to be applied to all locale's with mkDefault.";
    };
  };

  imports = optional pkgs.stdenv.isLinux ./default.linux.nix 
        ++ optional pkgs.stdenv.isDarwin ./default.darwin.nix;
}