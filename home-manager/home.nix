{ pkgs, inputs, outputs, config, ... }:
{
  /* -------------------------------- overlays -------------------------------- */
  nixpkgs.overlays = [ outputs.overlays.additions inputs.rust-overlay.overlays.default inputs.foundry.overlay inputs.solc.overlay ];

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
    (inputs.solc.mkDefault pkgs pkgs.solc_0_8_20)
    (rust-bin.stable.latest.default.override { extensions = [ "rust-src" "rustfmt" ]; })
    bacon
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
    # flowistry
    gavin-bc
    gcc
    gopls
    halp
    jaq
    nil
    nixpkgs-fmt
    nodePackages.vscode-langservers-extracted
    rage
    rust-analyzer-unwrapped
    sccache
    solc_0_8_20
    sops
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.awscli2
    pkgs.foundry-bin
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
  programs.gpg = {
    package = pkgs.gnupg.override { guiSupport = true; pinentry = pkgs.pinentry-gtk2; };
  };
  programs.go = {
    enable = true;
    goPrivate = [ "github.com/beeb" ];
  };
  programs.helix.languages = {
    language-server = {
      astro = {
        command = "${pkgs.nodePackages."@astrojs/language-server"}/bin/astro-ls";
        args = [ "--stdio" ];
        config.typescript.tsdk = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib";
      };
      ruff = with pkgs; {
        command = "${ruff-lsp}/bin/ruff-lsp";
      };
      typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
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
      solidity-language-server = with pkgs; {
        command = "${myNodePackages."@nomicfoundation/solidity-language-server"}/bin/nomicfoundation-solidity-language-server";
        args = [ "--stdio" ];
      };
    };
    language = [
      {
        name = "astro";
        language-servers = [ "astro" ];
        auto-format = true;
      }
      {
        name = "rust";
        auto-format = true;
      }
      {
        name = "python";
        language-servers = [ "ruff" ];
        formatter = with pkgs; {
          command = "${black}/bin/black";
          args = [ "--quiet" "--line-length" "120" "-" ];
        };
        auto-format = true;
      }
      {
        name = "typescript";
        auto-format = true;
        language-servers = [ "typescript-language-server" ];
        formatter = with pkgs; {
          command = "${biome}/bin/biome";
          args = [ "format" "--stdin-file-path" "test.ts" ];
        };
      }
      {
        name = "javascript";
        auto-format = true;
        formatter = with pkgs; {
          command = "${biome}/bin/biome";
          args = [ "format" "--stdin-file-path" "test.js" ];
        };
      }
      {
        name = "json";
        auto-format = true;
        formatter = with pkgs; {
          command = "${biome}/bin/biome";
          args = [ "format" "--stdin-file-path" "test.json" ];
        };
      }
      {
        name = "svelte";
        auto-format = true;
        language-servers = [ "svelteserver" ];
      }
      { name = "css"; auto-format = true; }
      {
        name = "nix";
        formatter.command = "nixpkgs-fmt";
        auto-format = true;
      }
      {
        name = "toml";
        auto-format = true;
        language-servers = [ "taplo" ];
      }
      {
        name = "yaml";
        language-servers = [ "yaml-language-server" ];
        auto-format = true;
      }
      # TODO: add astro once @astrojs/language-server is available on pkgs
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      {
        name = "solidity";
        language-servers = [ "solidity-language-server" ];
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
  programs.zoxide.enable = true;
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
  };

  /* -------------------------------- services -------------------------------- */
  services.gpg-agent = {
    enable = !pkgs.stdenv.isDarwin;
  };
}
