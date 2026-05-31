{
  description = "A accumulation of custom packages that nix does not have already.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let 
    # Define the architectures you intend to support
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    
    # Helper function to generate attributes for each system
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in
  {
    packages = forAllSystems (system: import ./pkgs/default.nix {pkgs = import nixpkgs { inherit system; config.allowUnfree = true; }; } );
  };
}
