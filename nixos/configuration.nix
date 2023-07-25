{ pkgs, inputs, outputs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    inputs.home-manager.nixosModules.home-manager
  ];

  users.defaultUserShell = pkgs.zsh;

  time.timeZone = "Europe/Zurich";

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      demo = import ../home-manager/virtualbox.nix; # imports all the stuff
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
