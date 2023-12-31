{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  home.packages = with pkgs; [
    espup
    trashy
  ];

  # Forwarding the agent and so on was too much of a pain and didn't work. Using the binary from Windows solves it.
  programs.git.signing.gpgPath = "/mnt/c/Program Files (x86)/GnuPG/bin/gpg.exe";
  programs.git.extraConfig.core.sshCommand = "ssh.exe";

  programs.zsh.shellAliases = {
    rt = "trash put";
    hms = "home-manager switch --flake ~/.dotfiles";
    hmu = "nix flake update ~/.dotfiles && hms";
  };

  sops.age.keyFile = "/home/valentin/.dotfiles/secrets/keys.txt";
}
