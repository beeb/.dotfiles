{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/Users/valentin";

  sops = {
    age.keyFile = "/Users/valentin/.config/sops/age/keys.txt";
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
