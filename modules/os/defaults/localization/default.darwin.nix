{ 
  pkgs,
  lib,
  config,
  stdenv,
  ...
}:
with lib;
let cfg = config.imperium.defaults.localization; 
in
{
  config = mkIf stdenv.isDarwin {
    # Make darwin version of the module... 
    # This might help https://blog.remibergsma.com/2012/07/10/setting-locales-correctly-on-mac-osx-terminal-application/
    
  };
}