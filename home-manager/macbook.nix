{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/Users/valentin";
  # Fails to build, see https://github.com/NixOS/nix/issues/8485
  manual.manpages.enable = false;

  sops.age.keyFile = "/Users/valentin/.dotfiles/secrets/keys.txt";

  home.packages = with pkgs; [
    pinentry_mac
  ];
  home.sessionVariables = {
    GPG_TTY = "$(tty)";
  };
  home.sessionPath = [
    "/Users/valentin/.foundry/bin"
  ];

  programs.alacritty = {
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Light";
        };
        size = 12;
        offset = { y = 1; };
      };
      window = {
        option_as_alt = "OnlyLeft";
      };
    };
  };
  programs.zsh = {
    shellAliases = {
      hms = "home-manager switch --flake ~/.dotfiles";
      hmu = "nix flake update --flake ~/.dotfiles && hms";
    };
  };
}
