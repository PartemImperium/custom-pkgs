{ 
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  config = {
    programs.zsh.enable = lib.mkDefault true;
  };
  
  imports = [
    ./default.linux.nix 
  ];
}
# Apperently this works in darwin as well (with the same syntax). So will keep this in the default module. If when I install this in darwin and that is not true then split this like other modules
