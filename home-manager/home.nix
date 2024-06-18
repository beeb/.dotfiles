{ pkgs, inputs, outputs, ... }:
{
  /* -------------------------------- overlays -------------------------------- */
  nixpkgs.overlays = [ outputs.overlays.additions inputs.foundry.overlay inputs.solc.overlay ];

  /* --------------------------------- system --------------------------------- */
  home.file = {
    ".cargo/config.toml".text = ''
      [build]
      rustc-wrapper = "sccache"
    '';
  };
  home.sessionVariables = { };
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops.defaultSopsFile = ../sops/common.yaml;
  sops.secrets.aws_codeartifact_script = {
    mode = "0540";
  };
  sops.secrets.aws_session_token_script = {
    mode = "0540";
  };

  /* -------------------------------- programs -------------------------------- */
  home.packages = with pkgs; [
    (inputs.solc.mkDefault pkgs pkgs.solc_0_8_25)
    biome
    bulloak
    bun
    cargo-binstall
    cargo-lambda
    cargo-machete
    cargo-outdated
    cargo-update
    convco
    dua
    fastmod
    gcc
    gopls
    jaq
    nil
    nixpkgs-fmt
    nodePackages.vscode-langservers-extracted
    rage
    rustup
    sccache
    solc_0_8_25
    solores
    sops
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.foundry-bin
    pkgs.gavin-bc
  ];
  programs.awscli = {
    enable = false;
    settings = {
      "default" = {
        region = "eu-central-1";
      };
      "login" = {
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
  programs.git.signing = {
    key = "4592122C5C6B53B1";
    signByDefault = true;
  };
  programs.gpg = {
    package = pkgs.gnupg.override { guiSupport = true; pinentry = pkgs.pinentry-gtk2; };
  };
  programs.go = {
    enable = true;
    goPrivate = [ "github.com/beeb" ];
  };
  programs.helix.languages = {
    grammar = [
      {
        name = "solidity";
        source = {
          git = "https://github.com/JoranHonig/tree-sitter-solidity";
          rev = "08338dcee32603383fcef08f36321900bb7a354b";
        };
      }
    ];
    language-server = {
      astro = {
        command = "${pkgs.nodePackages."@astrojs/language-server"}/bin/astro-ls";
        args = [ "--stdio" ];
        config.typescript.tsdk = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib";
      };
      biome = with pkgs; {
        command = "${biome}/bin/biome";
        args = [ "lsp-proxy" ];
      };
      ruff = with pkgs; {
        command = "${ruff-lsp}/bin/ruff-lsp";
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
      yaml-language-server = with pkgs.nodePackages; {
        command = "${yaml-language-server}/bin/yaml-language-server";
        args = [ "--stdio" ];
      };
      rust-analyzer.config = {
        checkOnSave.command = "clippy";
        inlayHints = {
          closingBraceHints.enable = false;
          parameterHints.enable = false;
          typeHints.enable = false;
        };
      };
      scls = with pkgs; {
        command = "${scls}/bin/simple-completion-language-server";
        config = {
          feature_snippets = false;
        };
      };
      solidity-language-server = with pkgs; {
        command = "${myNodePackages."@nomicfoundation/solidity-language-server"}/bin/nomicfoundation-solidity-language-server";
        args = [ "--stdio" ];
      };
      tailwindcss-ls = with pkgs; {
        command = "${myNodePackages."@tailwindcss/language-server"}/bin/tailwindcss-language-server";
        args = [ "--stdio" ];
      };
      typos = with pkgs; {
        command = "${typos-lsp}/bin/typos-lsp";
        config = {
          diagnosticSeverity = "information";
        };
      };
    };
    language = [
      {
        name = "astro";
        language-servers = [ "scls" "astro" "tailwindcss-ls" ];
        auto-format = true;
      }
      {
        name = "rust";
        language-servers = [ "scls" "rust-analyzer" ];
        auto-format = true;
      }
      {
        name = "python";
        language-servers = [ "scls" "ruff" ];
        formatter = with pkgs; {
          command = "${black}/bin/black";
          args = [ "--quiet" "--line-length" "120" "-" ];
        };
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
        language-servers = [ "scls" "svelteserver" "tailwindcss-ls" ];
      }
      {
        name = "css";
        language-servers = [ "scls" "vscode-css-language-server" "tailwindcss-ls" ];
        auto-format = true;
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
        language-servers = [ "scls" "taplo" ];
        formatter = with pkgs; {
          command = "${taplo}/bin/taplo";
          args = [ "fmt" "--option" "indent_string=    " "-" ];
        };
      }
      {
        name = "yaml";
        language-servers = [ "scls" "yaml-language-server" ];
        auto-format = true;
      }
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      {
        name = "solidity";
        language-servers = [ "scls" "solidity-language-server" "typos" ];
        formatter = {
          command = "${pkgs.foundry-bin}/bin/forge";
          args = [ "fmt" "-r" "-" ];
        };
        auto-format = true;
      }
    ];
  };
  programs.lazygit = {
    enable = true;
    settings.gui.theme.selectedLineBgColor = [ "black" ];
  };
  programs.navi.enable = true;
  programs.starship = {
    settings = {
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
      awstoken = "/run/user/1000/secrets/aws_session_token_script";
      npmrc = "/run/user/1000/secrets/aws_codeartifact_script";
    };
    envExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };

  /* -------------------------------- services -------------------------------- */
  services.gpg-agent = {
    enable = !pkgs.stdenv.isDarwin;
  };
  services.pueue = {
    enable = !pkgs.stdenv.isDarwin;
  };
}
