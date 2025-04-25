{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "crates-lsp";
  version = "0.1.7";

  src = fetchFromGitHub {
    owner = "MathiasPius";
    repo = "crates-lsp";
    rev = "v${version}";
    hash = "sha256-r+bSc98YsUc5ANc8WbXI8N2wdEF53uJoWQbsBHYmrGc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-UqQxhcDdD0b9rIG+nrAops2v5vcyj/pkL/3FLW3bsDQ=";

  doCheck = false;

  meta = {
    description = "Language Server implementation for Cargo.toml";
    homepage = "https://github.com/MathiasPius/crates-lsp";
    mainProgram = "crates-lsp";
  };
}
