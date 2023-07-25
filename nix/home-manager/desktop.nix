{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  home.packages = with pkgs; [
    trashy
  ];

  # Forwarding the agent and so on was too much of a pain and didn't work. Using the binary from Windows solves it.
  programs.git.signing.gpgPath = "/mnt/c/Program Files (x86)/GnuPG/bin/gpg.exe";

  programs.zsh.shellAliases = {
    rt = "trash put";
  };

  sops = {
    age.keyFile = "/home/valentin/.config/sops/age/keys.txt";
  };
}
