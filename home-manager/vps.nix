{ pkgs, ... }:
{
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";

  packages = with pkgs; [
    podman
  ];

  programs.zsh = {
    envExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };
}
