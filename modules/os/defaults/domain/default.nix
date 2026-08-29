{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  config = {
    networking = {
      domain = lib.mkDefault host.domain;
      hostName = lib.mkDefault host.hostname;
      fqdn = lib.mkDefault host.fullyQualifiedHostname;
    };
  };
}
# Apperently this works in darwin as well (with the same syntax). So will keep this in the default module. If when I install this in darwin and that is not true then split this like other modules
