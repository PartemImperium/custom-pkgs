{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = 
  [
    #TODO: Create import function that takes a dir and imports the default.nix and the corrisponding os default file (default.linux.nix or default.darwin.nixs)
    
    ./defaults/localization/default.nix
  ];
}