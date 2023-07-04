{ pkgs, ... }:
{
  home.username = "vbersier";
  home.homeDirectory = "/home/vbersier";

  sops = {
    age.keyFile = "/home/vbersier/.config/sops/age/keys.txt";
  };
}