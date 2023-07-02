{ sops-nix, config, pkgs, ... }:

{
  imports = [
    sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "home/valentin/.config/sops/age/keys.txt";
    defaultSopsFile = "../../secrets/common.yaml";
  };

  sops.secrets = {
    atuin_sync_server = { };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "valentin";
  home.homeDirectory = "/home/valentin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    bat
    cargo-binstall
    cargo-machete
    cargo-outdated
    cargo-update
    dotter
    du-dust
    exa
    fd
    fnm
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
    nixpkgs-fmt
    rage
    ripgrep
    rustup
    sccache
    sops
    starship
    zellij
    zoxide
    zsh
  ];

  programs.home-manager.enable = true;
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      inline_height = 25;
      search_mode = "skim";
      style = "compact";
      sync_address = config.sops.secrets.atuin_sync_server;
      sync_frequency = "5m";
      update_check = true;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/valentin/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "hx";
  };
}
