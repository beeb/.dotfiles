{ pkgs, ... }:
{
  /* ---------------------------------- system -------------------------------- */
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";
  home.file = {
    ".ssh/id_1password.pub".source = ../pubkeys/id_1password.pub;
  };
  fonts.fontconfig.enable = true;
  targets.genericLinux.enable = true;
  sops.age.keyFile = "/home/beeb/.dotfiles/secrets/keys.txt";

  /* -------------------------------- programs -------------------------------- */
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    anchor
    hunspell
    hunspellDicts.en-us
    hunspellDicts.fr-moderne
    libreoffice-qt
    nodejs_18
    nodePackages.rollup
    roundme
    spire
    telegram-desktop
    trashy
    ungoogled-chromium
    webcord
    wget
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
      font = {
        normal = {
          family = "JetBrainsMonoNL Nerd Font";
          style = "Light";
        };
        size = 10.5;
        offest = { y = 1; };
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
  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
      IdentityFile ~/.ssh/id_1password.pub
      IdentitiesOnly yes
    '';
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local act = wezterm.action
      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- Show which key table is active in the status area
      wezterm.on('update-right-status', function(window, pane)
        local name = window:active_key_table()
        if name then
          name = 'TABLE: ' .. name
        end
        window:set_right_status(name or ''\'''\')
      end)

      -- Maximize on start
      wezterm.on('gui-startup', function(cmd)
        local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
        window:gui_window():maximize()
      end)

      -- Change font for helix
      wezterm.on("update-status", function(window, pane)
        local info = pane:get_foreground_process_info()
        if info == nil then
          return
        end
        if info.name == ".hx-wrapped" or info.name == "hx" then
          window:set_config_overrides({
            font = wezterm.font {
              family = 'JetBrainsMonoNL Nerd Font',
              weight = 'Light'
            },
          })
        else
          window:set_config_overrides({
            font = wezterm.font {
              family = 'JetBrainsMono Nerd Font',
              weight = 'Light'
            },
          })
        end
      end)

      config.color_scheme = 'Catppuccin Mocha'
      config.font = wezterm.font {
        family = 'JetBrainsMono Nerd Font',
        weight = 'Light'
      }
      config.font_size = 10.5
      config.line_height = 1.05
      -- config.cell_width = 0.9
      -- config.freetype_load_target = "Light"
      config.freetype_load_target = "HorizontalLcd"
      config.window_close_confirmation = 'NeverPrompt'
      config.window_decorations = "RESIZE"
      config.audible_bell = "Disabled"
      config.visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = 'CursorColor',
      };

      config.keys = {
        -- C-p ot enter pane mode
        -- { key = 'p', mods = 'CTRL', action = act.ActivateKeyTable { name = 'pane', one_shot = true } },
        -- C-n to enter pane resize mode
        -- { key = 'n', mods = 'CTRL', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
        -- Move around panes with Alt (can also be done in C-p pane mode)
        -- { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
        -- { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
        -- { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
        -- { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
        -- { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
        -- { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
        -- { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
        -- { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
        -- Paste
        { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
        -- Close tab
        { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = false } },
        { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab { confirm = false } },
      }

      config.key_tables = {
        pane = {
          -- Pane split and close
          { key = 'r', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
          { key = 'd', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
          { key = 'x', action = act.CloseCurrentPane { confirm = false } },
          -- Move around
          { key = 'h', action = act.ActivatePaneDirection 'Left' },
          { key = 'l', action = act.ActivatePaneDirection 'Right' },
          { key = 'k', action = act.ActivatePaneDirection 'Up' },
          { key = 'j', action = act.ActivatePaneDirection 'Down' },

          { key = 'Escape', action = 'PopKeyTable' },
        },
        resize_pane = {
          { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 4 } },
          { key = 'h', action = act.AdjustPaneSize { 'Left', 4 } },
          { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 4 } },
          { key = 'l', action = act.AdjustPaneSize { 'Right', 4 } },
          { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 4 } },
          { key = 'k', action = act.AdjustPaneSize { 'Up', 4 } },
          { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 4 } },
          { key = 'j', action = act.AdjustPaneSize { 'Down', 4 } },

          { key = 'Escape', action = 'PopKeyTable' },
        }
      }

      config.background = {
        {
          source = {
            File = '/home/beeb/.dotfiles/img/terminal_bg.png',
          },
          hsb = { brightness = 0.5 },
        },
      }

      return config
    '';
  };
  programs.zellij = {
    enableZshIntegration = true;
  };
  programs.zsh = {
    shellAliases = {
      rt = "trash put";
      hms = "home-manager switch --flake ~/.dotfiles";
      hmu = "nix flake update --flake ~/.dotfiles && hms";
    };
    initExtra = ''
      function gpg_cache () {
        gpg-connect-agent /bye &> /dev/null
        eval $(op signin)
        op item get iavuc3a3tsdmhttass5rdvhsmy --fields password | "$(gpgconf --list-dirs libexecdir)"/gpg-preset-passphrase --preset 2F2C2096A6C39D0609D910300DECE20D665C8354
      }
    '';
    envExtra = ''
      export PATH="/home/beeb/.local/share/solana/install/active_release/bin:$PATH"
    '';
  };

  /* -------------------------------- services -------------------------------- */
  services.gpg-agent = {
    defaultCacheTtl = 3600;
    maxCacheTtl = 28800;
    extraConfig = ''
      allow-preset-passphrase
    '';
  };
}
