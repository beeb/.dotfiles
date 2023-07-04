{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  sops = {
    age.keyFile = "/home/valentin/.config/sops/age/keys.txt";
  };
}