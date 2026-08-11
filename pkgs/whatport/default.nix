{
  stdenv,
  lib,
  fetchzip,
}:
stdenv.mkDerivation rec {
    pname = "whatport";
    version = "1.10.0";

    src = fetchzip { #TODO: Create package from source instead of using pre built binary.
      url = "https://github.com/darrylmorley/whatport/releases/download/v${version}/WhatPort.zip";
      sha256 = "sha256-xlZadwfzAyE7+zS82RoIM+/YrgoABG0hkz09K9wenR0=";
      stripRoot = false;
    };

    sourceRoot = ".";

    phases = ["unpackPhase" "installPhase"];

    installPhase = ''
        # Move app to out
        mkdir -p $out/Applications

        mv "source/WhatPort.app" $out/Applications
    '';

    meta = with lib; {
        description = "A lightweight macOS menu bar utility that shows real-time USB-C and Thunderbolt port status. See what's connected, how fast it's running, and how much power each port is using.";
        license = licenses.mit;
        homepage = "https://www.whatport.app/";
        platforms = platforms.darwin;
    };
}