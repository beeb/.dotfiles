{ lib, config, pkgs, inputs, outputs, ... }:

{
  /* --------------------------------- Imports -------------------------------- */
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  /* ---------------------------------- SOPS ---------------------------------- */
  sops.defaultSopsFile = ../sops/common.yaml;
  sops.age.keyFile = "/home/beeb/.dotfiles/secrets/keys.txt";
  sops.secrets.beeb_password = {
    neededForUsers = true;
  };

  /* --------------------------------- nixpkgs -------------------------------- */
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
    hostPlatform = "x86_64-linux";
  };

  /* ---------------------------------- NixOS --------------------------------- */
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
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  /* ---------------------------------- boot ---------------------------------- */
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  /* --------------------------------- basics --------------------------------- */
  networking = {
    hostName = "aceraspire";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
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
  console.useXkbConfig = true;

  virtualisation.docker.enable = true;

  /* ---------------------------------- users --------------------------------- */
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      beeb = {
        description = "Valentin Bersier";
        passwordFile = config.sops.secrets.beeb_password.path;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # TODO: SSH public key(s) here, if you plan on using SSH to connect
        ];
        extraGroups = [ "networkmanager" "input" "lp" "wheel" "dialout" "docker" ];
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      beeb = import ../home-manager/work.nix; # imports all the stuff
    };
  };

  /* -------------------------------- programs -------------------------------- */
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # helps for Electron apps
  };
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    winetricks
  ];
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "beeb" ];
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };
  programs.zsh.enable = true;

  /* -------------------------------- services -------------------------------- */
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver = {
    # layout = "ch"; # for standard swiss french keyboard
    # xkbVariant = "fr"; # for standard swiss french keyboard
    layout = "rpsf";
    extraLayouts.rpsf = {
      description = "Real Programer Swiss French";
      languages = [ "eng" "fra" ];
      symbolsFile = ../kbd/RPSF.xkb;
    };
    xkbOptions = "caps:escape_shifted_capslock";
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        additionalOptions = ''
          Option "PalmDetection" "True"
        '';
        tappingButtonMap = "lrm";
      };
    };
  };
  # console.keyMap = "fr_CH"; # for standard swiss french keyboard
  services.printing.enable = true;

  /* ---------------------------------- sound --------------------------------- */
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  /* -------------------------------- hardware -------------------------------- */
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "23.05";
}
