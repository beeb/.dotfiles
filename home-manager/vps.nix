{ pkgs, ... }:
{
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";

  home.packages = with pkgs; [
    podman
  ];

  programs.zsh = {
    envExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };
}
