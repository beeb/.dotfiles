# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'

{ pkgs ? (import ./nixpkgs.nix) { } }: {
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [ nix home-manager git git-crypt ];
    # After shell is open, run `gpg --edit-key 0x4592122C5C6B53B1` and the `trust` command
    shellHook = ''
      gpg --import ~/.dotfiles/pubkeys/public.asc
      gpg-connect-agent "scd serialno" "learn --force" /bye
    '';
  };
}
