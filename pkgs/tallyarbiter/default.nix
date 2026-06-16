{
  pkgs,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
}:
let
  nodeVersion = pkgs.nodejs_26;
in
buildNpmPackage (finalAttrs: rec {
  pname = "tallyarbiter";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "josephdadams";
    repo = "tallyarbiter";
    rev = "v${version}"; 
    hash = "sha256-P3yNS3BQ2vnU/UEmNlSopiGtakXPJAk+LFhnuLTMT50="; 
  };

  nodejs = nodeVersion;

  npmDepsHash = "sha256-ggGaIkbd5uotuttTvAsQhFElgadGhFvU+JCtsbGTnbw=";

  # We dont need electron bin from npm. 
  env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  #TODO: Make electron desktop app part work

  ui = buildNpmPackage rec {
    pname = "tallyarbiter-ui";
    inherit (finalAttrs) version src;
    
    nodejs = nodeVersion;

    sourceRoot = "${finalAttrs.src.name}/UI";

    npmDepsHash = "sha256-KWK915JtJKUM5+t+Ew/LzahawDToH6Pc73vMxTkzfTQ=";

    # We patches the version creation script to look at these env vars.
    env.APP_VERSION = "${version}";
    env.APP_BRANCH = "${version}";
    env.APP_REMOTE = "${finalAttrs.src.url}";

    #TODO: Figure out how to use the redundancyjs cli like it is normally and not just cp...
    prePatch = ''
      cp ../src/_models/* src/app/_models
    '';

    patches = [
      ./patches/ui/dist.diff
      ./patches/ui/version.diff
      ./patches/ui/redundancy.diff
    ];

    env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

    installPhase = ''
      runHook preInstall

      cp -r dist $out

      runHook postInstall
    '';
  };

  # Copy out dist from the UI build
  preBuild = ''
    cp -r ${ui} dist_ui
  '';

  patches = [
    ./patches/bin.diff
  ];

})