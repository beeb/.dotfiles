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
  };

  /* ---------------------------------- NixOS --------------------------------- */
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
      };
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
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
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
    defaultUserShell = pkgs.fish;
    users = {
      beeb = {
        description = "Valentin";
        hashedPasswordFile = config.sops.secrets.beeb_password.path;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # TODO: SSH public key(s) here, if you plan on using SSH to connect
        ];
        extraGroups = [ "networkmanager" "input" "lp" "wheel" "dialout" "docker" ];
      };
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
      libthai
      zlib
      fuse
    ];
  };
  programs.fish.enable = true;
  programs.firefox.enable = true;

  /* -------------------------------- services -------------------------------- */
  services.xserver.enable = true;
  services.xserver = {
    xkb = {
      layout = "rpsf";
      extraLayouts.rpsf = {
        description = "Real Programer Swiss French";
        languages = [ "eng" "fra" ];
        symbolsFile = ../kbd/RPSF.xkb;
      };
      options = "caps:escape_shifted_capslock";
    };
  };
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      additionalOptions = ''
        Option "PalmDetection" "True"
      '';
      tappingButtonMap = "lrm";
    };
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.printing.enable = true;

  /* ---------------------------------- sound --------------------------------- */
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  /* -------------------------------- hardware -------------------------------- */
  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "25.05";
}
