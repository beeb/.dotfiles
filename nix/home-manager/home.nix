{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = "/home/valentin";

    packages = with pkgs; [
      atuin
      bat
      dotter
      du-dust
      exa
      fd
      fzf
      git
      halp
      helix
      htop
      lazygit
      magic-wormhole-rs
      navi
      neofetch
      nil
      ripgrep
      rustup
      sccache
      starship
      zellij
      zoxide
      zsh
    ];

    stateVersion = "23.05";
    username = "valentin";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.home-manager.enable = true;
}