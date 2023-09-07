{
  description = "beeb's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Rust overlay
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # Sops-nix
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Foundry
    foundry.url = "github:shazow/foundry.nix";
    foundry.inputs.nixpkgs.follows = "nixpkgs";

    # Solc
    solc.url = "github:hellwolf/solc.nix";
    solc.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, sops-nix, foundry, solc, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # FIXME replace with your hostname
        aceraspire = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./nixos/configuration.nix
          ];
        };
      };

      # Home manager configurations for non-nixOS machines
      homeConfigurations = builtins.mapAttrs
        (user: machine: home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${machine.system};

          modules = [
            ./home-manager/common.nix
            machine.file
          ] ++ nixpkgs.lib.optionals machine.home [
            ./home-manager/home.nix
          ];

          extraSpecialArgs = { inherit inputs outputs; };

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        })
        {
          "valentin@DESKTOP-SNQ577U" = { system = "x86_64-linux"; file = ./home-manager/desktop.nix; home = true; };
          "valentin" = { system = "x86_64-darwin"; file = ./home-manager/macbook.nix; home = true; };
          "beeb@beebvpn" = { system = "x86_64-linux"; file = ./home-manager/vpn.nix; home = false; };
          "beeb@vps" = { system = "x86_64-linux"; file = ./home-manager/vps.nix; home = false; };
        };
    };
}
