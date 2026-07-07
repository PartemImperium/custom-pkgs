{ 
  lib,
}:
rec {
  # Define the architectures you intend to support
  supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    
  # Helper function to generate attributes for each system
  forAllSystems = lib.genAttrs supportedSystems;

  # Helper function to create all the packages from a givin nixpkgs input
  createPackageSet = nixpkgs-set: forAllSystems (system: import ./pkgs/default.nix { pkgs = import nixpkgs-set { inherit system; config.allowUnfree = true; }; } );
}