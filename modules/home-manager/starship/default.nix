{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  # Helper method to keep the module options in sync for the 2 starship config types
  mkSettingsOption = desc: mkOption {
    type = types.attrs;
    default = {};
    description = desc;
  };

  tomlFormat = pkgs.formats.toml { };

  cfg = config.imperium.starship;
in
{
  options.imperium.starship = {
    enable = mkEnableOption "starship";

    package = mkPackageOption pkgs "starship" {};

    ttyConfig = mkSettingsOption "Starship configuration that will be used when the shell is running in a tty console. The tty console will have more limited feature set and should avoid more complicated features or colors.";

    pseudoConfig = mkSettingsOption "Starship configuration that will be used when the shell is running in a pseudo console (application running in GUI). The pseudo console will generally have more complicated features and color support.";
  };
#TODO: Add other shells and maybe features from the nixpkgs module https://github.com/NixOS/nixpkgs/blob/832dff5a2cc5e2bfbeb0ff1b30561594c3b66b62/nixos/modules/programs/starship.nix#L19
  config = mkIf cfg.enable {
    programs.zsh.initContent = mkOrder 9999 ''
    #Starship Module
    ttyPath=$(tty)#TODO: Make tty command use a pkg so it is not reliant on it existing.. coreutils has it but I am not sure 

    if [[ $ttyPath =~ /dev/tty[0-9]+ ]]; then
      export STARSHIP_CONFIG="${tomlFormat.generate "starship.toml" cfg.ttyConfig}"
    else
      export STARSHIP_CONFIG="${tomlFormat.generate "starship.toml" cfg.pseudoConfig}"
    fi

    if [[ $TERM != "dumb" ]]; then
      eval "$(${cfg.package}/bin/starship init zsh)"
    fi
    '';
  };
}