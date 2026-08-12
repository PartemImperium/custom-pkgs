{
  stdenv,
  lib,
  fetchzip,
}:
stdenv.mkDerivation rec {
    pname = "whatbattery";
    version = "1.6.0";

    src = fetchzip { #TODO: Create package from source instead of using pre built binary.
      url = "https://github.com/darrylmorley/whatbattery/releases/download/v${version}/WhatBattery.zip";
      sha256 = "sha256-OW9zxfUUdZFXDqPLmArSnBeEuQ/7Bn4YtNTOvnfR6PE=";
      stripRoot = false;
    };

    sourceRoot = ".";

    phases = ["unpackPhase" "installPhase"];

    installPhase = ''
        # Copy cli to out (we copy instead of move because the cli is just in the app bundle and we still need that to work)
        mkdir -p $out/bin
        
        cp "source/WhatBattery.app/Contents/Helpers/whatbattery" $out/bin/

        # Move app to out
        mkdir -p $out/Applications

        mv "source/WhatBattery.app" $out/Applications
    '';

    meta = with lib; {
        description = "A small macOS menu bar app that shows the real health of your battery, the live power going in and out, which apps are using it, and the service condition macOS uses, for your Mac and any iPhone or iPad you connect to it.";
        license = licenses.mit;
        homepage = "https://www.whatbattery.app/";
        platforms = platforms.darwin;
        sourceProvenance = sourceTypes.binaryNativeCode;
        mainProgram = "whatbattery";
    };
}