{ lib, config, pkgs, inputs, outputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../sops/common.yaml;
  sops.age.keyFile = "/home/beeb/.dotfiles/secrets/keys.txt";
  sops.secrets.beeb_password = {
    neededForUsers = true;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
    hostPlatform = "x86_64-linux";
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users = {
    # FIXME: Replace with your username
    beeb = {
      description = "Valentin Bersier";
      passwordFile = config.sops.secrets.beeb_password.path;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "networkmanager" "input" "lp" "wheel" "dialout" ];
    };
  };

  networking.hostName = "aceraspire";
  networking.networkmanager.enable = true;
  users.defaultUserShell = pkgs.zsh;
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_CH.UTF-8";
    LC_IDENTIFICATION = "fr_CH.UTF-8";
    LC_MEASUREMENT = "fr_CH.UTF-8";
    LC_MONETARY = "fr_CH.UTF-8";
    LC_NAME = "fr_CH.UTF-8";
    LC_NUMERIC = "fr_CH.UTF-8";
    LC_PAPER = "fr_CH.UTF-8";
    LC_TELEPHONE = "fr_CH.UTF-8";
    LC_TIME = "fr_CH.UTF-8";
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "beeb" ];
  };

  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  # hyprland doesn't work in a virtualbox for now
  # services.xserver.displayManager.defaultSession = "hyprland";
  services.xserver = {
    layout = "ch";
    xkbVariant = "fr";
    xkbOptions = "caps:escape_shifted_capslock";
  };
  console.keyMap = "fr_CH";
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  services.input-remapper.enable = true;

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      beeb = import ../home-manager/work.nix; # imports all the stuff
    };
  };

  # screensharing, link opening etc.
  # not sure if needed, should be enabled by hyprland's module
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  system.stateVersion = "23.05";
}
