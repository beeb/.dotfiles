{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/Users/valentin";
  # Fails to build, see https://github.com/NixOS/nix/issues/8485
  manual.manpages.enable = false;

  sops.age.keyFile = "/Users/valentin/.dotfiles/secrets/keys.txt";

  home.packages = with pkgs; [
    pinentry
  ];

  programs.zsh = {
    shellAliases = {
      hms = "home-manager switch --flake ~/.dotfiles";
      hmu = "nix flake update ~/.dotfiles && hms";
    };
  };
}
