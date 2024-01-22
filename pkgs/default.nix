# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  # flowistry = pkgs.callPackage ./flowistry { };
  myNodePackages = pkgs.callPackage ./myNodePackages { };
  roundme = pkgs.callPackage ./roundme { };
  substreams = pkgs.callPackage ./substreams { };
  spire = pkgs.callPackage ./spire { };
}
