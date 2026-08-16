{ 
  pkgs,
  lib,
  config,
  ...
}:
{
  config = {# Allow the "experimental" nix commmand and flakes features
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
# Apperently this works in darwin as well (with the same syntax). So will keep this in the default module. If when I install this in darwin and that is not true then split this like other modules
