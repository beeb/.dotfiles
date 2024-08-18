{ rustPlatform
, fetchFromGitHub
, lib
, installShellFiles
, rust-jemalloc-sys
,
}:

rustPlatform.buildRustPackage {
  pname = "yazi-master";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "99a3b3a043502a32877148515d6992e0fa121137";
    hash = "sha256-XA5RWcmKWHyc8LSQuV/X00rh1vvvOJ+XyHCwR9Yn4K4=";
  };

  cargoHash = "sha256-zFLUTAR+TJrmJRhTOCLuq9cM39xO9g72Q73LmV3c7Dc=";

  env.YAZI_GEN_COMPLETIONS = true;
  env.VERGEN_GIT_SHA = "Nixpkgs";
  env.VERGEN_BUILD_DATE = "2024-08-18";

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
