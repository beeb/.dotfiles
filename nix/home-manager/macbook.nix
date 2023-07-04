{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/Users/valentin";

  sops = {
    age.keyFile = "/Users/valentin/Library/Application Support/sops/age/keys.txt";
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
