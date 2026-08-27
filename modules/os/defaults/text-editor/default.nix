{ 
  pkgs,
  lib,
  config,
  ...
}:
{
  config = {# Add vim and nano so we always have a text editor
    environment.systemPackages = with pkgs; [
      vim
      nano
    ];
  };
}
