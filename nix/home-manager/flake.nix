{
  description = "Home Manager configuration of valentin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:mic92/sops-nix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, rust-overlay, ... }@inputs:
    {
      homeConfigurations."valentin@DESKTOP-SNQ577U" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          inputs.sops-nix.homeManagerModules.sops
          ({ ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          })
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      homeConfigurations."valentin@valentins-macbook-pro.home" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [
          ./home.nix
          ./macbook.nix
          inputs.sops-nix.homeManagerModules.sops
          ({ ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          })
        ];
      };
    };
}
