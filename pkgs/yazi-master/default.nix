{ rustPlatform
, fetchFromGitHub
, lib
, installShellFiles
, rust-jemalloc-sys
,
}:

rustPlatform.buildRustPackage rec {
  pname = "yazi-master";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "v${version}";
    hash = "sha256-tK2dm+WIEJGSq/PbRyagt7x43nd/o1HxP8HMj23HfnQ=";
  };

  # cargoLock = {
  #   lockFile = ./Cargo.lock;
  # };
  cargoHash = "sha256-oD697EWa9YYFGAXFPoN0OKLmidMjZYHuD+khRh7B0/s=";

  env.YAZI_GEN_COMPLETIONS = true;
  env.VERGEN_GIT_SHA = "Nixpkgs";
  env.VERGEN_BUILD_DATE = "2024-08-01";

  nativeBuildInputs = [ installShellFiles ];
  buildInputs = [ rust-jemalloc-sys ];

  postInstall = ''
    installShellCompletion --cmd yazi \
      --bash ./yazi-boot/completions/yazi.bash \
      --fish ./yazi-boot/completions/yazi.fish \
      --zsh  ./yazi-boot/completions/_yazi

    install -Dm444 assets/yazi.desktop -t $out/share/applications
    install -Dm444 assets/logo.png $out/share/pixmaps/yazi.png
  '';

  passthru.updateScript.command = [ ./update.sh ];

  meta = {
    description = "Blazing fast terminal file manager written in Rust, based on async I/O";
    homepage = "https://github.com/sxyazi/yazi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      xyenon
      matthiasbeyer
      linsui
      eljamm
    ];
    mainProgram = "yazi";
  };
}
