# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  crates-lsp = pkgs.callPackage ./crates-lsp { };
  heimdall-rs = pkgs.callPackage ./heimdall-rs { };
  myNodePackages = pkgs.callPackage ./myNodePackages { };
  scls = pkgs.callPackage ./scls { };
  solar = pkgs.callPackage ./solar { };
  solores = pkgs.callPackage ./solores { };
}
