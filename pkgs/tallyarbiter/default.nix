{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
}:
let
  nodeVersion = pkgs.nodejs_24;  
in
buildNpmPackage (finalAttrs: rec {
  pname = "tallyarbiter";
  version = "3.3.0";

  src = fetchFromGitHub {
    owner = "josephdadams";
    repo = "tallyarbiter";
    rev = "v${version}"; 
    hash = "sha256-oApaVhU0Ywv79wVLGh+xXISl39z1QzP2aaVO0fT5Wes="; 
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

    npmDepsHash = "sha256-UwKMJPJsleFZLy8eZUhnB6UIml9ZpUhnOq0Y+8cPpBY=";

    # We patches the version creation script to look at these env vars.
    env.APP_VERSION = "${version}";
    env.APP_BRANCH = "${version}";
    env.APP_REMOTE = "${finalAttrs.src.url}";

    #TODO: Figure out how to use the redundancyjs cli like it is normally and not just cp...
    # prePatch = ''
    #   mkdir -p src/app/_models
    #   cp ../src/_models/* src/app/_models

    #   mkdir -p src/app/_types
    #   cp ../src/_types/* src/app/_types
      
    #   mkdir -p src/_schemas/
    #   cp ../src/_helpers/configSchema.ts src/_schemas/configSchema.ts
    # '';
    patches = [
      ./patches/ui/dist.diff
      ./patches/ui/version.diff
      # ./patches/ui/redundancy.diff #TODO: Remove this line and the file after this works... This was needed in the old version
    ];

    env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

    installPhase = ''
      runHook preInstall

      cp -r dist $out

      runHook postInstall
    '';
  };

  # Copy out dist from the UI build
  preInstall = ''
    
    cp -r ${ui} dist_ui
  '';

  patches = [
    ./patches/bin.diff
  ];
#https://github.com/NixOS/nixpkgs/blob/ed162fff81c9f93d06d89c93ef901dee2765ac1d/pkgs/by-name/lx/lx-music-desktop/package.nix
# ^^^^^^^^^^^^^^^^^^ Example of electron app  
meta = {
    description = "The flexible and customizable camera tally light system";
    longDescription = "A camera tally lights system capable of listening to and aggregating tally data from multiple sources and video switchers, then arbitrating Preview and Program states for connected devices.";
    homepage = "https://www.tallyarbiter.com";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
})