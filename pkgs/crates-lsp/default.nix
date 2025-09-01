{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "crates-lsp";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "MathiasPius";
    repo = "crates-lsp";
    rev = "v${version}";
    hash = "sha256-9+0qgdUn5l9oQQavbnR6rHe5zp5WHhGuRyOXt2Dv8Tw=";
  };

  cargoHash = "sha256-oS6xi8BH5vCVOimYWsDoW0Na7eUXzeHKKSOwpK9wbu8=";

  doCheck = false;

  meta = {
    description = "Language Server implementation for Cargo.toml";
    homepage = "https://github.com/MathiasPius/crates-lsp";
    mainProgram = "crates-lsp";
  };
}
