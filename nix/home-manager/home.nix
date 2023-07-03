{ pkgs, ... }:

{

  sops = {
    age.keyFile = "/home/valentin/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/common.yaml;
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
    _1password
    cargo-binstall
    cargo-machete
    cargo-outdated
    cargo-update
    dotter
    du-dust
    fd
    fnm
    git-crypt
    gopls
    halp
    magic-wormhole-rs
    neofetch
    nil
    nixpkgs-fmt
    nodePackages.vscode-langservers-extracted
    rage
    rust-bin.stable.latest.default
    rust-analyzer-unwrapped
    sccache
    sops
  ];

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      inline_height = 25;
      search_mode = "skim";
      style = "compact";
      sync_address = builtins.readFile ../../.secrets/atuin-sync-server;
      sync_frequency = "5m";
      update_check = true;
    };
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
    };
    themes = {
      catppuccin = builtins.readFile (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        } + "/Catppuccin-mocha.tmTheme");
    };
  };
  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [ "--color=always" "--group-directories-first" ];
  };
  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    delta.enable = true;
    signing.key = builtins.readFile ../../.secrets/gpg_key_id;
    signing.signByDefault = true;
    userEmail = "703631+beeb@users.noreply.github.com";
    userName = "beeb";
    extraConfig = {
      core = {
        editor = "hx";
      };
    };
  };
  programs.go = {
    enable = true;
    goPrivate = [ "github.com/beeb" ];
  };
  programs.gpg.enable = true;
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
          config.checkOnSave.command = "clippy";
          config.inlayHints = {
            closingBraceHints.enable = false;
            parameterHints.enable = false;
            typeHints.enable = false;
          };
        }
        {
          name = "python";
          language-server = with pkgs.python3.pkgs; {
            command = "${ruff-lsp}/bin/ruff-lsp";
          };
          formatter = with pkgs; {
            command = "${black}/bin/black";
            args = [ "--quiet" "--line-length" "120" "-" ];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          auto-format = true;
          language-server = with pkgs.nodePackages; {
            command = "${typescript-language-server}/bin/typescript-language-server";
            args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
          };
        }
        {
          name = "svelte";
          auto-format = true;
          language-server = with pkgs.nodePackages; {
            command = "${svelte-language-server}/bin/svelteserver";
          };
        }
        { name = "css"; auto-format = true; }
        # TODO: add astro once @astrojs/language-server is available on pkgs
        {
          name = "nix";
          formatter.command = "nixpkgs-fmt";
          auto-format = true;
        }
        {
          name = "yaml";
          language-server = with pkgs.nodePackages; {
            command = "${yaml-language-server}/bin/yaml-language-server";
          };
          auto-format = true;
        }
      ];
    };
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        true-color = true;
        bufferline = "multiple";
        rulers = [ 120 ];
        auto-format = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        file-picker.hidden = false;
        soft-wrap.enable = true;
      };
      keys = {
        normal = {
          g.D = [ "hsplit" "jump_view_up" "goto_definition" ];
          F8 = "goto_next_diag";
          C-space = "expand_selection";
          X = "extend_line_above";
          esc = [ "collapse_selection" "keep_primary_selection" ];
          space.i = [ ":toggle-option lsp.display-inlay-hints" ];
        };
        insert = {
          C-c = "normal_mode";
        };
      };
    };
  };
  programs.home-manager.enable = true;
  programs.htop.enable = true;
  programs.lazygit = {
    enable = true;
    settings.gui.theme.selectedLineBgColor = [ "black" ];
  };
  programs.navi.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 10000;
      add_newline = true;
      cmd_duration = {
        format = "in [$duration]($style) ";
        style = "bold italic green";
        show_notifications = true;
      };
      sudo = {
        disabled = false;
      };
      container = {
        disabled = true;
      };
      aws = { symbol = "  "; };
      buf = { symbol = " "; };
      c = { symbol = " "; };
      conda = { symbol = " "; };
      dart = { symbol = " "; };
      directory = { read_only = " 󰌾"; };
      docker_context = { symbol = " "; };
      elixir = { symbol = " "; };
      elm = { symbol = " "; };
      fossil_branch = { symbol = " "; };
      git_branch = { symbol = " "; };
      golang = { symbol = " "; };
      guix_shell = { symbol = " "; };
      haskell = { symbol = " "; };
      haxe = { symbol = "⌘ "; };
      hg_branch = { symbol = " "; };
      hostname = { ssh_symbol = " "; };
      java = { symbol = " "; };
      julia = { symbol = " "; };
      lua = { symbol = " "; };
      memory_usage = { symbol = "󰍛 "; };
      meson = { symbol = "󰔷 "; };
      nim = { symbol = "󰆥 "; };
      nix_shell = { symbol = " "; };
      nodejs = { symbol = " "; };
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };
      package = { symbol = "󰏗 "; };
      pijul_channel = { symbol = "🪺 "; };
      python = { symbol = " "; };
      rlang = { symbol = "󰟔 "; };
      ruby = { symbol = " "; };
      rust = { symbol = " "; };
      scala = { symbol = " "; };
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      theme = "catppuccin-mocha";
    };
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      save = 100000;
      size = 100000;
    };
    initExtra = with pkgs; ''
      function gpg_cache () {
        gpg-connect-agent /bye &> /dev/null
        eval $(op signin)
        op item get ${builtins.readFile ../../.secrets/op_item_id} --fields password | ${gnupg}/bin/libexec/gpg-preset-passphrase --preset ${builtins.readFile ../../.secrets/gpg_key_fingerprint}
      }

      zstyle ':completion:*' menu select
      bindkey '^[[Z' reverse-menu-complete

      eval "$(fnm env --use-on-cd)"
    '';
    profileExtra = "";
    shellAliases = {
      cat = "bat";
      g = "lazygit";
      cd = "z";
      ze = "zellij";
      za = "zellij a -c";
      wormhole = "wormhole-rs";
      hm = "home-manager";
      hms = "home-manager switch --flake ~/.dotfiles/nix/home-manager";
      hmp = "home-manager packages";
      hmu = "nix flake update ~/.dotfiles/nix/home-manager && hms";
    };
    envExtra = ''
      export PATH="$PATH:$HOME/.foundry/bin"
    '';
  };
  programs.zoxide.enable = true;

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-preset-passphrase
    '';
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
    ".cargo/config.toml".text = ''
      [build]
      rustc-wrapper = "sccache"
    '';
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
  home.sessionVariables = { };
}
