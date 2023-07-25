{ inputs, outputs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    inputs.home-manager.nixosModules.home-manager
  ];

  time.timeZone = "Europe/Zurich";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      demo = import ../home-manager/virtualbox.nix; # imports all the stuff
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
