{ ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];
  time.timeZone = "Europe/Zurich";
  nixpkgs.hostPlatform = "x86_64-linux";
}
