{
  description = "A accumulation of custom packages that nix does not have already.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello-imperium = nixpkgs.legacyPackages.x86_64-linux.hello;

  };
}
