{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  config = {# Allow the "experimental" nix commmand and flakes features
    services.openssh.enable = lib.mkDefault host.isServer;
  };
}
# Apperently this works in darwin as well (with the same syntax). So will keep this in the default module. If when I install this in darwin and that is not true then split this like other modules
