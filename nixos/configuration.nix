{ ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];
  time.timeZone = "Europe/Zurich";
}
