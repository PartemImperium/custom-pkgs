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
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "Locale to be applied to all locale's with mkDefault.";
    };
  };

  imports = [
    ./default.linux.nix 
    ./default.darwin.nix
  ];
}