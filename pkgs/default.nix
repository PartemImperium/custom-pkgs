{ pkgs }:

rec {
    xlaserpointer = pkgs.callPackage ./xlaserpointer/default.nix {};
    plex-dbrepair = pkgs.callPackage ./plex-dbrepair/default.nix {};
    whatcable = pkgs.callPackage ./whatcable/default.nix {};
}