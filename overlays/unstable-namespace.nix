{
  nixpkgs-unstable,
}:
final: prev: {
  unstable = import nixpkgs-unstable {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };
}