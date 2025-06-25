{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  home.file = {
    ".config/fish/conf.d/nix-env.fish" = {
      source = ../fish/nix-env.fish;
    };
  };
  home.packages = with pkgs; [
    espup
    trashy
  ];
  home.sessionPath = [
    "$HOME/.deno/bin"
  ];

  programs.git = {
    # Forwarding the agent and so on was too much of a pain and didn't work. Using the binary from Windows solves it.
    signing = {
      format = "openpgp";
      signer = "/mnt/c/Program Files (x86)/GnuPG/bin/gpg.exe";
    };
    extraConfig = {
      core.sshCommand = "ssh.exe";
    };
  };

  programs.jujutsu.settings.signing.backends.gpg.program = "/mnt/c/Program Files (x86)/GnuPG/bin/gpg.exe";

  programs.fish.shellAliases = {
    rt = "trash put";
    hms = "home-manager switch --flake ~/.dotfiles";
    hmu = "nix flake update --flake ~/.dotfiles && hms";
    ssh = "ssh.exe";
    ssh-add = "ssh-add.exe";
  };
  programs.zsh = {
    shellAliases = {
      rt = "trash put";
      hms = "home-manager switch --flake ~/.dotfiles";
      hmu = "nix flake update --flake ~/.dotfiles && hms";
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
    };
  };

  sops.age.keyFile = "/home/valentin/.dotfiles/secrets/keys.txt";
}
