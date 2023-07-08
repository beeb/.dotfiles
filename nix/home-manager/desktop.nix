{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  home.packages = with pkgs; [
    trashy
  ];

  sops = {
    age.keyFile = "/home/valentin/.config/sops/age/keys.txt";
  };
}
