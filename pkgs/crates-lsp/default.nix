{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "crates-lsp";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "MathiasPius";
    repo = "crates-lsp";
    rev = "v${version}";
    hash = "sha256-wA2kxwY2EjPZioh/YbGmoLcW7nYJmjXpA7uquKk/6pQ=";
  };

  cargoHash = "sha256-+sQdmGeFH8Zj9IIaIubQXuAmypZUA8gEtHmdwWq8ENk=";

  doCheck = false;

  meta = {
    description = "Language Server implementation for Cargo.toml";
    homepage = "https://github.com/MathiasPius/crates-lsp";
    mainProgram = "crates-lsp";
  };
}
