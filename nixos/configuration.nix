{ lib, config, pkgs, inputs, outputs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking.hostName = "nixos";

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  time.timeZone = "Europe/Zurich";

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      demo = import ../home-manager/virtualbox.nix; # imports all the stuff
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.05";
}
