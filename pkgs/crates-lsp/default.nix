{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "crates-lsp";
  version = "0.1.6";

  src = fetchFromGitHub {
    owner = "MathiasPius";
    repo = "crates-lsp";
    rev = "v${version}";
    hash = "sha256-P4cFwD4WY0AxoG9xwyLY1ZTXj0ZfoarXVeido60nUmQ=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-RXUn0hi1iicLjgllul3bDfVYqsO63XdMI77t7GsS9zc=";

  doCheck = false;

  meta = {
    description = "Language Server implementation for Cargo.toml";
    homepage = "https://github.com/MathiasPius/crates-lsp";
    mainProgram = "crates-lsp";
  };
}
