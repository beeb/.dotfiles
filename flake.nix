{
  description = "beeb's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    foundry.url = "github:shazow/foundry.nix/stable";
    foundry.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, sops-nix, foundry, nixgl, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
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
      # Available through 'sudo nixos-rebuild --flake ~/.dotfiles'
      nixosConfigurations = {
        aceraspire = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./nixos/configuration.nix
          ];
        };
      };

      # Home manager configurations
      # Available through `home-manager switch --flake --impure ~/.dotfiles`
      homeConfigurations = builtins.mapAttrs
        (user: machine: home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.${machine.system};

          modules = [
            inputs.plasma-manager.homeManagerModules.plasma-manager
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
          "valentin@desktop" = { system = "x86_64-linux"; file = ./home-manager/desktop.nix; home = true; };
          "valentin" = { system = "x86_64-darwin"; file = ./home-manager/macbook.nix; home = true; };
          "beeb@beebvpn" = { system = "x86_64-linux"; file = ./home-manager/vpn.nix; home = false; };
          "beeb@vps" = { system = "aarch64-linux"; file = ./home-manager/vps.nix; home = false; };
          "beeb@aceraspire" = { system = "x86_64-linux"; file = ./home-manager/work.nix; home = true; };
        };
    };
}
