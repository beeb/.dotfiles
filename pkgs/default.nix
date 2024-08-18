# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  heimdall-rs = pkgs.callPackage ./heimdall-rs { };
  myNodePackages = pkgs.callPackage ./myNodePackages { };
  roundme = pkgs.callPackage ./roundme { };
  scls = pkgs.callPackage ./scls { };
  soldeer = pkgs.callPackage ./soldeer { };
  solores = pkgs.callPackage ./solores { };
  spire = pkgs.callPackage ./spire { };
  substreams = pkgs.callPackage ./substreams { };
  yazi-master = pkgs.callPackage ./yazi-master { };
}
