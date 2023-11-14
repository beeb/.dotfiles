{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, installShellFiles
}:

rustPlatform.buildRustPackage rec {
  pname = "tlrc";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "tldr-pages";
    repo = "tlrc";
    rev = "v${version}";
    hash = "sha256-Jdie9ESSbRV07SHjITfQPwDKTedHMbY01FdEMlNOr50=";
  };

  cargoHash = "sha256-2OXyPtgdRGIIc7jIES9zhRpFiaodcEnaK88k+rUVSJo=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installManPage tldr.1

    installShellCompletion --cmd tldr \
      --bash <(cat completions/tldr.bash) \
      --fish <(cat completions/tldr.fish) \
      --zsh <(cat completions/_tldr)
  '';

  doCheck = false;

  meta = with lib; {
    description = "A tldr client written in Rust";
    homepage = "https://tldr.sh/tlrc/";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ beeb ];
  };

  COMPLETION_DIR = "completions";
}
