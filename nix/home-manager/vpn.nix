{ pkgs, ... }:
{
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";

  home.packages = with pkgs; [
    wireguard-tools
  ];
}
