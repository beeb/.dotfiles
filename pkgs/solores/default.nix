{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "solores";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "igneous-labs";
    repo = "solores";
    rev = "v${version}";
    hash = "sha256-Q6grrJpSfwpOZtkZ8iKakT842u9wJUQ0Gkrj108h/us=";
  };

  cargoHash = "sha256-UdruR0b3fDJMj92C3dOdd4/asWBfzrdeXxdFDwaKyTc=";

  buildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.SystemConfiguration ];

  doCheck = false;

  meta = {
    description = "Solana IDL to Rust client / CPI interface generator";
    homepage = "https://github.com/igneous-labs/solores";
    mainProgram = "solores";
  };
}
