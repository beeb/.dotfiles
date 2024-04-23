{ pkg-config
, udev
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "anchor-cli";
  version = "0.30.0";

  src = fetchFromGitHub {
    owner = "coral-xyz";
    repo = "anchor";
    rev = "v${version}";
    hash = "sha256-RvYJoGmACoPfdbeXK2uYutleHPT0kAlOCDJX4NP9q4I=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "serum_dex-0.4.0" = "sha256-Nzhh3OcAFE2LcbUgrA4zE2TnUMfV0dD4iH6fTi48GcI=";
    };
  };
  cargoBuildFlags = "--bin=anchor";

  doCheck = false;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];

  meta = {
    description = "Solana Sealevel Framework CLI";
    homepage = "https://www.anchor-lang.com";
    mainProgram = "anchor";
  };
}
