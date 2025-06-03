# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

pkgs: {
  crates-lsp = pkgs.callPackage ./crates-lsp { };
  myNodePackages = pkgs.callPackage ./myNodePackages { };
  scls = pkgs.callPackage ./scls { };
}
