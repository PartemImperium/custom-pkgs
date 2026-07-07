{
  unstable-nixpkgs,
}:
{
  unstable = (import ./unstable-namespace.nix { nixpkgs-unstable = unstable-nixpkgs; });
  
  custom = (import ./custom-packages-namespace.nix { nixpkgs-unstable = unstable-nixpkgs; });
}