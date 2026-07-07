{
  description = "A accumulation of custom packages, nixos modules, home manager modules (and in the future nix-darwin modules) that nixpkgs does not have already.";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

  };
  outputs = 
    { 
      self,
      nixpkgs-unstable,
      nixpkgs-stable,
      home-manager,
    }: 
  let 
    pkg-set-lib = import ./pkg-set-lib.nix { lib = nixpkgs-stable.lib; }; 
  in
  {
    packages = pkg-set-lib.createPackageSet nixpkgs-stable;

    homeModules.custom = 
      { ... }:
      {
         imports = [ ./modules/home-manager/default.nix ]; 
      };

    # Typically you dont want to pass things into a overlay like this. However this is putting entire package sets in a namespace and the overlay wont have the info it needs without it.
    overlays = {
      unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (final) config;
          inherit (final.stdenv.hostPlatform) system;
        };
      };

      custom = final: prev: 
      {
        custpkgs = pkg-set-lib.createPackageSet final;
        custpkgs_unstable = pkg-set-lib.createPackageSet nixpkgs-unstable;
      };
    };
    # overlays = import ./overlays/default.nix { unstable-nixpkgs = nixpkgs-unstable; };
  };
}
