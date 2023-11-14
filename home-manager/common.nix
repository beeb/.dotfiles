{ pkgs, outputs, ... }:
{
  /* -------------------------- nixpkgs and overlays -------------------------- */
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  /* --------------------------------- system --------------------------------- */
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.file = { };

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

  /* -------------------------------- programs -------------------------------- */
  home.packages = with pkgs.unstable; [
    du-dust
    fd
    git-crypt
    magic-wormhole-rs
    neofetch
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
      sync_address = "https://atuin.beeb-wol.cc";
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
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };
  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [ "--color=always" "--group-directories-first" ];
  };
  programs.git = {
    enable = true;
    userEmail = "703631+beeb@users.noreply.github.com";
    userName = "beeb";
    extraConfig = {
      core = {
        editor = "hx";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.gpg = {
    enable = true;
    publicKeys = [{
      source = ../pubkeys/public.asc;
      trust = 5;
    }];
    settings = {
      throw-keyids = true;
    };
  };
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      my_catppuccin = {
        inherits = "catppuccin_mocha";
        "ui.background" = { };
      };
    };
    settings = {
      theme = "my_catppuccin";
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
          C-j = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
          C-k = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ];
        };
        insert = {
          C-c = "normal_mode";
        };
      };
    };
  };
  programs.home-manager.enable = true;
  programs.htop.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 10000;
      add_newline = true;
      cmd_duration = {
        format = "in [$duration]($style) ";
        style = "bold italic green";
      };
      sudo = {
        disabled = false;
      };
      container = {
        disabled = true;
      };
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      theme = "catppuccin-mocha";
    };
  };
  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      save = 100000;
      size = 100000;
    };
    initExtra = ''
      zstyle ':completion:*' menu select
      bindkey '^[[Z' reverse-menu-complete
      bindkey '^[[3~' delete-char
    '';
    shellAliases = {
      cat = "bat";
      cd = "z";
      ze = "zellij";
      za = "zellij a -c";
      wormhole = "wormhole-rs";
      nrs = "sudo nixos-rebuild switch --impure --flake ~/.dotfiles";
      yubi = ''gpg-connect-agent "scd serialno" "learn --force" /bye'';
    };
  };
}
