{ pkgs, ... }:
{
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";

  home.packages = with pkgs; [
    podman
  ];
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
