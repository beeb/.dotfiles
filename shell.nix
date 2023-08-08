# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'

{ pkgs ? (import ./nixpkgs.nix) { } }: {
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [ nix home-manager git gnupg git-crypt pinentry ];
    # Last command is to allow to trust the key with the `trust` command
    shellHook = ''
      gpg --import ~/.dotfiles/home-manager/public.asc
      gpg-connect-agent "scd serialno" "learn --force" /bye
      gpg --edit-key 0x4592122C5C6B53B1
    '';
  };
}
