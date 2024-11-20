{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "solar";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "paradigmxyz";
    repo = "solar";
    rev = "53e1f85b4bedda6bdc75319d3ee29639054b2cf3";
    hash = "sha256-qWyQG+yHnhQ+zs1fEKvPBku1NzkdPQIPuyH4NSWQ7Fw=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ui_test-0.27.1" = "sha256-ow7p+4jc0iaWCU2MWkpXKh5HEwfae27AnTdZN6+5Vx8=";
    };
  };

  doCheck = false;

  meta = {
    description = "Blazingly fast, modular and contributor friendly Solidity compiler, written in Rust";
    homepage = "https://github.com/paradigmxyz/solar";
    mainProgram = "solar";
  };
}
