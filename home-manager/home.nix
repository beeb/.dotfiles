{ pkgs, inputs, outputs, ... }:
{
  /* -------------------------------- overlays -------------------------------- */
  nixpkgs.overlays = [ outputs.overlays.additions inputs.foundry.overlay ];

  /* --------------------------------- system --------------------------------- */
  home.file = {
    ".cargo/config.toml".text = ''
      [build]
      rustc-wrapper = "sccache"
    '';
    ".config/sops/age/keys.txt".source = ../secrets/keys.txt;
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
  home.shell = {
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops.defaultSopsFile = ../sops/common.yaml;

  /* -------------------------------- programs -------------------------------- */
  home.packages = with pkgs; [
    atac
    biome
    bulloak
    bun
    cargo-binstall
    cargo-dist
    cargo-machete
    cargo-nextest
    cargo-outdated
    cargo-semver-checks
    cargo-update
    claude-code
    convco
    dua
    gcc
    gemini-cli
    gopls
    jaq
    kondo
    mergiraf
    nil
    nixpkgs-fmt
    nodePackages.vscode-langservers-extracted
    ouch
    repgrep
    rustup
    sccache
    sops
    systemctl-tui
    typst
    typst-live
    uv
    xh
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.foundry-bin
    pkgs.gavin-bc
    pkgs.cargo-lambda
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "~/.config/alacritty/catppuccin-mocha.toml" ];
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
          { key = "Return"; mods = "Shift"; chars = "\n"; }
        ];
      };
      mouse = {
        hide_when_typing = true;
      };
    };
  };
  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = "eu-central-1";
      };
    };
  };
  programs.bacon = {
    enable = true;
    settings = { };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fzf.enable = true;
  programs.git = {
    attributes = [
      "*.java merge=mergiraf"
      "*.rs merge=mergiraf"
      "*.go merge=mergiraf"
      "*.js merge=mergiraf"
      "*.jsx merge=mergiraf"
      "*.json merge=mergiraf"
      "*.yml merge=mergiraf"
      "*.yaml merge=mergiraf"
      "*.toml merge=mergiraf"
      "*.html merge=mergiraf"
      "*.htm merge=mergiraf"
      "*.xhtml merge=mergiraf"
      "*.xml merge=mergiraf"
      "*.c merge=mergiraf"
      "*.cc merge=mergiraf"
      "*.h merge=mergiraf"
      "*.cpp merge=mergiraf"
      "*.hpp merge=mergiraf"
      "*.cs merge=mergiraf"
      "*.dart merge=mergiraf"
      "*.dts merge=mergiraf"
      "*.scala merge=mergiraf"
      "*.sbt merge=mergiraf"
      "*.ts merge=mergiraf"
      "*.tsx merge=mergiraf"
      "*.py merge=mergiraf"
      "*.php merge=mergiraf"
      "*.sol merge=mergiraf"
      "*.lua merge=mergiraf"
      "*.kt merge=mergiraf"
      "*.rb merge=mergiraf"
    ];
    extraConfig = {
      merge.mergiraf = {
        name = "mergiraf";
        driver = "${pkgs.mergiraf}/bin/mergiraf merge --git -s %S -x %X -y %Y -p %P -l %L %O %A %B";
      };
    };
    signing = {
      key = "4592122C5C6B53B1";
      signByDefault = true;
    };
  };
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Catppuccin Mocha";
      font-style = "Light";
      font-size = 10.5;
      window-width = 10000; # start maximized
      window-height = 10000; # start maximized
      copy-on-select = "clipboard";
      app-notifications = "no-clipboard-copy";
      shell-integration-features = "no-cursor";
      keybind = [ "ctrl+v=paste_from_clipboard" "shift+enter=text:\\n" ];
    };
  };
  programs.gpg = {
    package = pkgs.gnupg.override { guiSupport = true; pinentry = pkgs.pinentry-gtk2; };
  };
  programs.go = {
    enable = true;
    env.GOPRIVATE = [ "github.com/beeb" ];
  };
  programs.helix.languages = {
    grammar = [
      {
        name = "solidity";
        source = {
          git = "https://github.com/JoranHonig/tree-sitter-solidity";
          rev = "f7f5251a3f5b1d04f0799b3571b12918af177fc8";
        };
      }
    ];
    language-server = {
      astro = {
        command = "${pkgs.astro-language-server}/bin/astro-ls";
        args = [ "--stdio" ];
        config.typescript.tsdk = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib";
      };
      biome = {
        command = "biome";
        args = [ "lsp-proxy" ];
      };
      crates = with pkgs; {
        command = "${crates-lsp}/bin/crates-lsp";
      };
      ruff = with pkgs; {
        command = "${ruff}/bin/ruff";
        args = [ "server" ];
        config.settings.lineLength = 120;
      };
      typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = [ "--stdio" ];
      };
      svelteserver = with pkgs.nodePackages; {
        command = "${svelte-language-server}/bin/svelteserver";
      };
      taplo = with pkgs; {
        command = "${taplo}/bin/taplo";
        args = [ "lsp" "stdio" ];
      };
      tinymist = with pkgs; {
        command = "${tinymist}/bin/tinymist";
        config.formatterMode = "typstyle";
      };
      yaml-language-server = with pkgs.nodePackages; {
        command = "${yaml-language-server}/bin/yaml-language-server";
        args = [ "--stdio" ];
      };
      rust-analyzer.config = {
        check.command = "clippy";
        inlayHints = {
          closingBraceHints.enable = false;
          parameterHints.enable = false;
          typeHints.enable = false;
        };
        cargo.allFeatures = true;
      };
      scls = with pkgs; {
        command = "${scls}/bin/simple-completion-language-server";
        config.feature_snippets = false;
      };
      solidity-language-server = with pkgs; {
        command = "${myNodePackages."@nomicfoundation/solidity-language-server"}/bin/nomicfoundation-solidity-language-server";
        args = [ "--stdio" ];
      };
      tailwindcss-ls = with pkgs; {
        command = "${tailwindcss-language-server}/bin/tailwindcss-language-server";
        args = [ "--stdio" ];
      };
      harper = with pkgs; {
        command = "${harper}/bin/harper-ls";
        args = [ "--stdio" ];
        config.harper-ls = {
          linters = {
            SentenceCapitalization = false;
            LongSentences = false;
          };
        };
      };
    };
    language = [
      {
        name = "astro";
        language-servers = [ "scls" "astro" "tailwindcss-ls" "harper" ];
        auto-format = true;
      }
      {
        name = "rust";
        language-servers = [ "scls" "rust-analyzer" "harper" ];
        auto-format = true;
      }
      {
        name = "python";
        language-servers = [ "scls" "ruff" ];
        auto-format = true;
      }
      {
        name = "typescript";
        auto-format = true;
        language-servers = [ "scls" { name = "typescript-language-server"; except-features = [ "format" ]; } "biome" ];
        formatter = with pkgs; {
          command = "${biome}/bin/biome";
          args = [ "format" "--stdin-file-path" "test.ts" ];
        };
      }
      {
        name = "javascript";
        auto-format = true;
        language-servers = [ "scls" { name = "typescript-language-server"; except-features = [ "format" ]; } "biome" ];
        formatter = with pkgs; {
          command = "${biome}/bin/biome";
          args = [ "format" "--stdin-file-path" "test.js" ];
        };
      }
      {
        name = "json";
        auto-format = true;
        language-servers = [ "scls" "biome" ];
        formatter = with pkgs; {
          command = "${biome}/bin/biome";
          args = [ "format" "--stdin-file-path" "test.json" ];
        };
      }
      {
        name = "svelte";
        auto-format = true;
        language-servers = [ "scls" "biome" "tailwindcss-ls" "harper" ];
      }
      {
        name = "css";
        language-servers = [ "scls" "vscode-css-language-server" "tailwindcss-ls" ];
        auto-format = true;
      }
      {
        name = "markdown";
        language-servers = [ "harper" ];
      }
      {
        name = "nix";
        language-servers = [ "scls" "nil" ];
        formatter.command = "nixpkgs-fmt";
        auto-format = true;
      }
      {
        name = "toml";
        auto-format = true;
        language-servers = [ "scls" "taplo" { name = "crates"; except-features = [ "format" ]; } "harper" ];
        formatter = with pkgs; {
          command = "${taplo}/bin/taplo";
          args = [ "fmt" "--option" "indent_string=    " "-" ];
        };
      }
      {
        name = "yaml";
        language-servers = [ "scls" "yaml-language-server" "harper" ];
        auto-format = true;
      }
      {
        name = "typst";
        language-servers = [ "tinymist" "harper" ];
        auto-format = true;
      }
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      {
        name = "solidity";
        language-servers = [ "scls" "solidity-language-server" "harper" ];
        formatter = {
          command = "${pkgs.foundry-bin}/bin/forge";
          args = [ "fmt" "-r" "-" ];
        };
        auto-format = true;
      }
    ];
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "703631+beeb@users.noreply.github.com";
        name = "beeb";
      };
      signing = {
        "sign-all" = true;
        "backend" = "gpg";
        "key" = "4592122C5C6B53B1";
      };
      git.subprocess = true;
    };
  };
  programs.starship = {
    settings = {
      aws = { symbol = "  "; };
      buf = { symbol = " "; };
      c = { symbol = " "; };
      cmake = { symbol = " "; };
      conda = { symbol = " "; };
      crystal = { symbol = " "; };
      dart = { symbol = " "; };
      directory = { read_only = " 󰌾"; };
      docker_context = { symbol = " "; };
      elixir = { symbol = " "; };
      elm = { symbol = " "; };
      fennel = { symbol = " "; };
      fossil_branch = { symbol = " "; };
      git_branch = { symbol = " "; };
      git_commit = { tag_symbol = "  "; };
      golang = { symbol = " "; };
      guix_shell = { symbol = " "; };
      haskell = { symbol = " "; };
      haxe = { symbol = " "; };
      hg_branch = { symbol = " "; };
      hostname = { ssh_symbol = " "; };
      java = { symbol = " "; };
      julia = { symbol = " "; };
      kotlin = { symbol = " "; };
      lua = { symbol = " "; };
      memory_usage = { symbol = "󰍛 "; };
      meson = { symbol = "󰔷 "; };
      nim = { symbol = "󰆥 "; };
      nix_shell = { symbol = " "; };
      nodejs = { symbol = " "; };
      ocaml = { symbol = " "; };
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CachyOS = " ";
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
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        Nobara = " ";
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
        Void = " ";
        Windows = "󰍲 ";
      };
      package = { symbol = "󰏗 "; };
      perl = { symbol = " "; };
      php = { symbol = " "; };
      pijul_channel = { symbol = "🪺 "; };
      python = { symbol = " "; };
      rlang = { symbol = "󰟔 "; };
      ruby = { symbol = " "; };
      rust = { symbol = " "; };
      scala = { symbol = " "; };
      swift = { symbol = " "; };
      zig = { symbol = " "; };
      gradle = { symbol = " "; };
    };
  };
  programs.fish = {
    shellAliases = {
      g = "lazygit";
      c = "convco commit";
    };
  };
  programs.zsh = {
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = with pkgs; "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.zsh";
      }
    ];
    shellAliases = {
      g = "lazygit";
      c = "convco commit";
    };
  };

  /* -------------------------------- services -------------------------------- */
  services.gpg-agent = {
    enable = !pkgs.stdenv.isDarwin;
  };
  services.pueue = {
    enable = !pkgs.stdenv.isDarwin;
  };
}
