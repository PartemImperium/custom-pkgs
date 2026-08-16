{ 
  stdenv,
  fetchFromGitHub,
  writeShellApplication,
  lib,

  bash,
  plexRaw,
}:

let 
  script-version = "1.15.00";
  realScript = stdenv.mkDerivation {
    name = "plex-dbrepair-raw";
    version = script-version;

    # The core mechanism to fetch from GitHub
    src = fetchFromGitHub {
      owner = "ChuckPa";
      repo = "DBRepair";
      rev = "v${script-version}"; # Can be a tag or a specific git commit hash
      hash = "sha256-6xgve0tTAGLKYiAujBwIqHKE0swYJvo8n5efTtN2f7w="; 
    };

    installPhase = ''
      mkdir -p $out/bin
      cp ./DBRepair.sh $out/bin/
      chmod +x $out/bin/*
    '';
  };
in
writeShellApplication rec {
  name = "plex-dbrepair";

  # Skips shellcheck and avoids network/evaluation overhead
  checkPhase = ":"; 

  # Libraries needed for the final binary
  runtimeInputs = [ plexRaw bash ];

  text = ''
    sqlite="${plexRaw}/lib/plexmediaserver/Plex SQLite";
    ${bash}/bin/bash ${realScript}/bin/DBRepair.sh --sqlite "$sqlite" $@
  '';

    meta = with lib; {
        description = "Shell script to help fix various Plex db courptions.";
        homepage = "https://github.com/ChuckPa/DBRepair/";
        platforms = platforms.all;
        mainProgram = name;
    };
}