{
  pkgs,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
}:
buildNpmPackage (finalAttrs: rec {
  pname = "tallyarbiter";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "josephdadams";
    repo = "tallyarbiter";
    rev = "v${version}"; 
    hash = "sha256-P3yNS3BQ2vnU/UEmNlSopiGtakXPJAk+LFhnuLTMT50="; 
  };

  npmDepsHash = "sha256-ggGaIkbd5uotuttTvAsQhFElgadGhFvU+JCtsbGTnbw=";

  # We dont need electron bin from npm. 
  env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  #TODO: Make electron desktop app part work

  ui = buildNpmPackage rec {
    pname = "tallyarbiter-ui";
    inherit (finalAttrs) version src;

    npmDepsHash = "sha256-ggGaIkbd5uotuttTvAsQhFElgadGhFvU+JCtsbGTnbw=";
    env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

  };

  preInstall = ''
    mkdir -p $out/bin/ui
    cp -r ${ui}/bin $out/bin/ui
    cp -r ${ui}/lib $out/bin/ui

    
  '';
  nodejs = pkgs.nodejs_26;
})