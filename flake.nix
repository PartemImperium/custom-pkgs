{
  description = "A accumulation of custom packages that nix does not have already.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello-imperium = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.xlaserpointer = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation rec {
      pname = "xlaserpointer";
      version = "1.0.0";
      src = nixpkgs.legacyPackages.x86_64-linux.fetchFromGitHub {
        owner = "PartemImperium";
        repo = "xlaserpointer";
        rev = "v${version}"; 
        hash = "sha256-PXArDTeeQ4PyUviT6t4LEDM+LoEwj9Gy/x3qV+KS428="; 
      };

      # Tools needed during build time (like cmake)
      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux;[ cmake pkg-config xorg.libX11 xorg.libXfixes xorg.libXi cairo ];
    };
  };
}
