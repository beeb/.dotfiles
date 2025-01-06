{ pkgs, inputs, outputs, ... }:
{
  /* -------------------------- nixpkgs and overlays -------------------------- */
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
      inputs.nixgl.overlay
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

  home.file = {
    ".config/zellij/layouts/helix.kdl" = {
      source = ../zellij/helix-layout.kdl;
    };
    ".config/alacritty/catppuccin-mocha.toml" = {
      source = ../alacritty/catppuccin-mocha.toml;
    };
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

  /* -------------------------------- programs -------------------------------- */
  home.packages = with pkgs; [
    du-dust
    fd
    git-crypt
    just
    magic-wormhole-rs
    neofetch
    sd
    tlrc
    (writeShellScriptBin "yz-fp" ''
      #!/bin/env bash
      selected_file="$1"
      zellij action toggle-floating-panes
      zellij action write 27 # send escape key
      zellij action write-chars ":open $selected_file"
      zellij action write 13 # send enter key
      zellij action toggle-floating-panes
      zellij action close-pane
    '')
    (writeShellScriptBin "floating-yazi" ''
      #!/bin/env bash
      zellij run -c -f --width 80% --height 80% -x 10% -y 10% -- yazi "$PWD"
    '')
    (writeShellScriptBin "floating-lazygit" ''
      #!/bin/env bash
      zellij run -c -f --width 80% --height 80% -x 10% -y 10% -- lazygit
    '')
  ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
    pkgs.nixgl.nixGLIntel
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "~/.config/alacritty/catppuccin-mocha.toml" ];
      env = { TERM = "xterm-256color"; };
      window = {
        startup_mode = "Maximized";
        padding = {
          x = 5;
          y = 5;
        };
      };
      keyboard = {
        bindings = [
          { key = "V"; mods = "Control"; action = "Paste"; }
        ];
      };
      mouse = {
        hide_when_typing = true;
      };
    };
  };
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      inline_height = 25;
      style = "compact";
      sync_address = "https://atuin.beeb-wol.cc";
      sync_frequency = "2";
      update_check = true;
      sync = {
        records = true;
      };
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
    git = true;
    icons = "auto";
    extraOptions = [ "--color=always" "--group-directories-first" ];
  };
  # programs.ghostty = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   settings = {
  #     theme = "catppuccin-mocha";
  #   };
  # };
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
    ignores = [
      ".helix/ignore"
      ".helix/languages.toml"
      ".helix/config.toml"
      ".copilotignore"
    ];
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
        "ui.virtual.jump-label" = { fg = "#fc44d4"; modifiers = [ "bold" ]; };
        "diagnostic.error" = { bg = "crust"; };
        "diagnostic.warning" = { bg = "crust"; };
        "diagnostic.info" = { bg = "crust"; };
        "diagnostic.hint" = { bg = "crust"; };
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
          display-inlay-hints = false;
          auto-signature-help = false;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        soft-wrap.enable = true;
        file-picker.hidden = false; # show hidden files
        statusline = {
          center = [ "version-control" ];
        };
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
      keys = {
        normal = {
          g.D = [ "hsplit" "jump_view_up" "goto_definition" ]; # go to definition in new split
          F8 = "goto_next_diag"; # go to next diagnostic
          C-space = "expand_selection"; # smart selection grow
          X = [ "extend_line_up" "extend_to_line_bounds" ]; # move line selection up (unselect or select upwards)
          esc = [ "collapse_selection" "keep_primary_selection" ]; # better escape
          space.i = [ ":toggle-option lsp.display-inlay-hints" ]; # toggle inlay hints
          C-j = [ "extend_to_line_bounds" "delete_selection" "paste_after" ]; # move current line down
          C-k = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ]; # move current line up
          C-e = [ "search_selection" "extend_search_next" ]; # add to selection the next match of the current selection
          C-f = [ ":sh floating-yazi" ]; # yazi file picker
          C-l = [ ":sh floating-lazygit" ]; # lazygit
          C-r = [ ":reload-all" ]; # reload all files from disk
        };
        select = {
          C-space = "expand_selection"; # smart selection grow
          X = [ "extend_line_up" "extend_to_line_bounds" ]; # move line selection up (unselect or select upwards)
          C-e = [ "search_selection" "extend_search_next" ]; # add to selection the next match of the current selection
        };
        insert = {
          C-c = "normal_mode"; # exit insert mode with ctrl+c
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
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      manager.prepend_keymap = [
        { on = [ "|" ]; run = "help"; }
        { on = [ "<C-k>" ]; run = "seek -5"; }
        { on = [ "<C-j>" ]; run = "seek 5"; }
      ];
    };
    settings = {
      manager = {
        show_hidden = true;
      };
      opener = {
        helix = [{
          run = "yz-fp \"$0\"";
          desc = "Use yazi as file picker within helix";
        }];
      };
      open = {
        rules = [{
          name = "**/*";
          use = "helix";
        }];
      };
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
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
      autoload edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line
    '';
    shellAliases = {
      cat = "bat --style auto";
      cd = "z";
      h = "zellij -l helix";
      ze = "zellij";
      zk = "zellij kill-all-sessions";
      wormhole = "wormhole-rs";
      nrs = "sudo nixos-rebuild switch --impure --flake ~/.dotfiles";
      yubi = ''gpg-connect-agent "scd serialno" "learn --force" /bye'';
    };
  };
}
