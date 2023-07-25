{ pkgs, ... }:
{
  home.username = "valentin";
  home.homeDirectory = "/Users/valentin";
  # Fails to build, see https://github.com/NixOS/nix/issues/8485
  manual.manpages.enable = false;

  sops = {
    age.keyFile = "/Users/valentin/Library/Application Support/sops/age/keys.txt";
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
