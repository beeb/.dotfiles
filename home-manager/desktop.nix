{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  home.packages = with pkgs; [
    espup
    heimdall-rs
    trashy
  ];

  programs.git = {
    # Forwarding the agent and so on was too much of a pain and didn't work. Using the binary from Windows solves it.
    signing.gpgPath = "/mnt/c/Program Files (x86)/GnuPG/bin/gpg.exe";
    extraConfig = {
      core.sshCommand = "ssh.exe";
    };
  };

  programs.zsh = {
    shellAliases = {
      rt = "trash put";
      hms = "home-manager switch --flake ~/.dotfiles";
      hmu = "nix flake update ~/.dotfiles && hms";
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
    };
    envExtra = ''
      export PATH="/home/valentin/.local/share/solana/install/active_release/bin:$PATH"
    '';
  };

  sops.age.keyFile = "/home/valentin/.dotfiles/secrets/keys.txt";
}
