{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,

  python313Packages,
  argparse,
}:
python313Packages.buildPythonApplication (finalAttrs: rec {
  pname = "tallyarbiter-gpo-listener";
  version = "3.2.0";
  pyproject = false;

  #TODO: Sync this with the src of the main package.
  src = fetchFromGitHub {
    owner = "josephdadams";
    repo = "tallyarbiter";
    rev = "v${version}"; 
    hash = "sha256-P3yNS3BQ2vnU/UEmNlSopiGtakXPJAk+LFhnuLTMT50="; 
  };

  sourceRoot = "${finalAttrs.src.name}/listener_clients/gpo-listener";
    
  propagatedBuildInputs = [
    python313Packages.rpi-gpio
    python313Packages.socketio-client
    python313Packages.zeroconf
    argparse
  ];

     dontUnpack = true;
    installPhase = ''
      ls .
        install -Dm755 "gpo-listener.py" "$out/bin/${pname}"
    '';

  meta = {
    description = "The flexible and customizable camera tally light system";
    longDescription = "A camera tally lights system capable of listening to and aggregating tally data from multiple sources and video switchers, then arbitrating Preview and Program states for connected devices.";
    homepage = "https://www.tallyarbiter.com";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
})