{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  home.packages = with pkgs.unstable; [
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
    bacon
    cargo-binstall
    cargo-machete
    cargo-outdated
    cargo-update
    dotter
    gcc
    gopls
    halp
    nil
    nixpkgs-fmt
    rust-analyzer-unwrapped
    nodePackages.vscode-langservers-extracted
    rage
    sccache
    sops
  ] ++ [
    (pkgs.rust-bin.stable.latest.default.override { extensions = [ "rust-src" "rustfmt" ]; })
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fzf.enable = true;
  programs.git.signing = {
    key = "4592122C5C6B53B1";
    signByDefault = true;
  };
  programs.go = {
    enable = true;
    goPrivate = [ "github.com/beeb" ];
  };
  programs.helix.languages = {
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
        language-server = with pkgs.unstable.python3.pkgs; {
          command = "${ruff-lsp}/bin/ruff-lsp";
        };
        formatter = with pkgs.unstable; {
          command = "${black}/bin/black";
          args = [ "--quiet" "--line-length" "120" "-" ];
        };
        auto-format = true;
      }
      {
        name = "typescript";
        auto-format = true;
        language-server = with pkgs.unstable.nodePackages; {
          command = "${typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
        };
        formatter = with pkgs.unstable; {
          command = "${rome}/bin/rome";
          args = [ "format" "--stdin-file-path" "test.ts" ];
        };
      }
      {
        name = "javascript";
        auto-format = true;
        formatter = with pkgs.unstable; {
          command = "${rome}/bin/rome";
          args = [ "format" "--stdin-file-path" "test.js" ];
        };
      }
      {
        name = "json";
        auto-format = true;
        formatter = with pkgs.unstable; {
          command = "${rome}/bin/rome";
          args = [ "format" "--stdin-file-path" "test.json" ];
        };
      }
      {
        name = "svelte";
        auto-format = true;
        language-server = with pkgs.unstable.nodePackages; {
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
        name = "toml";
        auto-format = true;
        language-server = with pkgs.unstable; {
          command = "${taplo}/bin/taplo";
        };
      }
      {
        name = "yaml";
        language-server = with pkgs.unstable.nodePackages; {
          command = "${yaml-language-server}/bin/yaml-language-server";
        };
        auto-format = true;
      }
    ];
  };
  programs.lazygit = {
    enable = true;
    settings.gui.theme.selectedLineBgColor = [ "black" ];
  };
  programs.lf = {
    enable = true;
    settings = {
      color256 = true;
      dirfirst = true;
      drawbox = true;
      hidden = true;
      icons = true;
      preview = true;
      ignorecase = true;
    };
  };
  programs.navi.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 10000;
      add_newline = true;
      cmd_duration = {
        format = "in [$duration]($style) ";
        style = "bold italic green";
        # show_notifications = false;
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
  programs.zoxide.enable = true;
  # only add settings not already defined in common.nix
  # programs.zsh.initExtra = ''
  #   eval "$(fnm env --use-on-cd)"
  # '';
  programs.zsh.plugins = [
    {
      name = "zsh-syntax-highlighting";
      src = with pkgs.unstable; "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
      file = "zsh-syntax-highlighting.zsh";
    }
  ];
  programs.zsh.shellAliases = {
    g = "lazygit";
  };

  services.gpg-agent = {
    enable = !pkgs.stdenv.isDarwin;
  };

  home.file = {
    ".cargo/config.toml".text = ''
      [build]
      rustc-wrapper = "sccache"
    '';
  };

  home.sessionVariables = { };
}
