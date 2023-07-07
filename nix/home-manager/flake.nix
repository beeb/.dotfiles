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

  outputs = { nixpkgs, home-manager, rust-overlay, ... }@inputs: {
    nix.settings.sandbox = true;
    homeConfigurations = builtins.mapAttrs
      (user: machine: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${machine.system};

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./common.nix
          machine.file
        ] ++ nixpkgs.lib.optionals machine.home [
          ./home.nix
          inputs.sops-nix.homeManagerModules.sops
          ({ ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          })
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      })
      {
        "valentin@DESKTOP-SNQ577U" = { system = "x86_64-linux"; file = ./desktop.nix; home = true; };
        "vbersier@PANEER" = { system = "x86_64-linux"; file = ./paneer.nix; home = true; };
        "valentin" = { system = "x86_64-darwin"; file = ./macbook.nix; home = true; };
        "beeb@beebvpn" = { system = "x86_64-linux"; file = ./vpn.nix; home = false; };
      };
  };
}
