{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./home.nix
  ];


  home.username = "demo";
  home.homeDirectory = "/home/demo";

  home.packages = with pkgs.unstable; [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    trashy
  ];

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

      config.color_scheme = 'Catppuccin Mocha'
      config.font = wezterm.font {
        family = 'JetBrainsMono Nerd Font',
        weight = 'Light'
      }
      config.font_size = 13
      config.cell_width = 0.9
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
        { key = 'p', mods = 'CTRL', action = act.ActivateKeyTable { name = 'pane', one_shot = true } },
        -- C-n to enter pane resize mode
        { key = 'n', mods = 'CTRL', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
        -- Move around panes with Alt (can also be done in C-p pane mode)
        { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
        { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
        { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
        { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
        { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
        { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
        { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
        { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
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

      return config
    '';
  };

  programs.zsh.shellAliases = {
    rt = "trash put";
  };
}