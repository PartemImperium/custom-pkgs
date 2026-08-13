{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
  electron,
}:
buildNpmPackage rec {
  pname = "octodash";
  version = "2.8.0";

  src = fetchFromGitHub {
    owner = "UnchartedBull";
    repo = "OctoDash";
    rev = "v${version}"; 
    hash = "sha256-rz4xKWsq6EEiv/kiX+ByH7TI70hyX5xSweD4Dn22l0w="; 
  };

  nodejs = pkgs.nodejs_24;

  npmDepsHash = "sha256-i/4oPrQVwpAHR/J2AQs6Y6WzXgrCtpfOmxFnJLNQGTY=";

  # We dont need electron bin from npm. 
  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
    ELECTRON_OVERRIDE_DIST_PATH = ${electron}/bin;
  };


  # Tools needed during build time (like electron)
  nativeBuildInputs = with pkgs;
  [
     electron
     libgtkflow3#libgtk-3-0
     libnotify#libnotify4
     libnss_nis#libnss3
     libxtst#libxtst6
     xdg-utils#xdg-utils
     libuuid#libuuid1
     libappindicator-gtk3#libappindicator3-1
     libsecret#libsecret-1-0
     xorg-server#xserver-xorg
     ratpoison#ratpoison
     xinit#xinit
     bc#bc
     desktop-file-utils#desktop-file-utils
     #libavahi-compat-libdnssd1
     #libpam0g-dev
     #libx11-dev
     #x11-xserver-utils
     #libxss1
     #libatspi2.0-0
  ];
 

  buildPhase = ''
    npm run prepare

    npm run build

    npm run electron:pack
  '';

  #https://github.com/NixOS/nixpkgs/blob/ed162fff81c9f93d06d89c93ef901dee2765ac1d/pkgs/by-name/lx/lx-music-desktop/package.nix
  # ^^^^^^^^^^^^^^^^^^ Example of electron app  
  meta = {
    description = "The flexible and customizable camera tally light system";
    longDescription = "A camera tally lights system capable of listening to and aggregating tally data from multiple sources and video switchers, then arbitrating Preview and Program states for connected devices.";
    homepage = "https://www.tallyarbiter.com";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}