{
  nixpkgs-unstable,
}:
final: prev: 
let
  pkg-set-lib = import ../pkg-set-lib.nix { lib = prev.lib; }; 
in
{
  custpkgs = pkg-set-lib.createPackageSet final;
  custpkgs_unstable = pkg-set-lib.createPackageSet nixpkgs-unstable;
}