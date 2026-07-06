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
    # Define the architectures you intend to support
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    
    # Helper function to generate attributes for each system
    forAllSystems = nixpkgs-stable.lib.genAttrs supportedSystems;
  in
  {
    packages = forAllSystems (system: import ./pkgs/default.nix {pkgs = import nixpkgs-stable { inherit system; config.allowUnfree = true; }; } );

    homeModules.custom = 
      { ... }:
      {
         imports = [ ./modules/home-manager/default.nix ]; 
      };
  };
}
