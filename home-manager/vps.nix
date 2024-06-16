{ pkgs, ... }:
{
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";

  programs.zsh = {
    envExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };
}
