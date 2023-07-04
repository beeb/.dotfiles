{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/Users/vbersier";

  sops = {
    age.keyFile = "/Users/vbersier/.config/sops/age/keys.txt";
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
