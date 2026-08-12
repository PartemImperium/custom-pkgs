{
  stdenv,
  lib,
  fetchzip,
}:
stdenv.mkDerivation rec {
    pname = "whatcable";
    version = "1.4.0";

    srcs = [
      (fetchzip { #TODO: Create package from source instead of using pre built binary.
        url = "https://github.com/darrylmorley/whatcable/releases/download/v${version}/WhatCable.zip";
        sha256 = "sha256-DdQvnT/fhz5iHwT3/93OUBGw4t2NgfiVwgWK6GnfWDA=";
        stripRoot = false;
        name = "app";
      })
      (fetchzip { #TODO: Create package from source instead of using pre built binary.
        url = "https://github.com/darrylmorley/whatcable/releases/download/v${version}/whatcable-cli-${version}.zip";
        sha256 = "sha256-QXf33yWuli7ycqg1TAGsBPC8ZnoeC0/NRBFbzguT0HY=";
        stripRoot = true;
        name = "bin";
      })
    ];

    sourceRoot = ".";

    phases = ["unpackPhase" "installPhase"];

    installPhase = ''
        # Move app to out
        mkdir -p $out/Applications

        mv "app/WhatCable.app" $out/Applications

        # Move cli to out
        mkdir -p $out/bin

        mv bin $out
    '';

    meta = with lib; {
        description = "A small macOS menu bar app that tells you, in plain English, what each USB-C cable plugged into your Mac can actually do, and why your Mac might be charging slowly.";
        license = licenses.mit;
        homepage = "https://www.whatcable.uk/";
        platforms = platforms.darwin;
        sourceProvenance = sourceTypes.binaryNativeCode;
        mainProgram = "whatcable";
    };
}