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
    
    ./defaults/domain/default.nix
    ./defaults/localization/default.nix
    ./defaults/networking/default.nix
    ./defaults/nix-exprerimental-features/default.nix
    ./defaults/printing/default.nix
    ./defaults/text-editor/default.nix
    ./defaults/domain/default.nix
    ./defaults/zsh/default.nix
  ];
}