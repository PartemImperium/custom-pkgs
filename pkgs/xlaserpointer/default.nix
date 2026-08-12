{
  pkgs,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "xlaserpointer";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "PartemImperium";
    repo = "xlaserpointer";
    rev = "v${version}"; 
    hash = "sha256-PXArDTeeQ4PyUviT6t4LEDM+LoEwj9Gy/x3qV+KS428="; 
  };

  # Tools needed during build time (like cmake)
  nativeBuildInputs = with pkgs;[ cmake pkg-config libX11 libXfixes libXi cairo ];

    meta = with lib; {
        description = "Linux utility to change the cursor into a strobey laser pointer for screencasts and presentations, a la the feature in Google Slides and most other slide deck applications.";
        license = licenses.mit;
        homepage = "https://github.com/PartemImperium/xlaserpointer/";
        platforms = platforms.linux;
        mainProgram = "xlaserpointer";
    };
}