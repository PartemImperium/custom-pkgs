{ pkgs }:

rec {
    xlaserpointer = pkgs.callPackage ./xlaserpointer/default.nix {};
    plex-dbrepair = pkgs.callPackage ./plex-dbrepair/default.nix {};
    tallyarbiter = pkgs.callPackage ./tallyarbiter/default.nix {};
}