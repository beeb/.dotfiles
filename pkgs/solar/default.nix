{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "solar";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "paradigmxyz";
    repo = "solar";
    rev = "3a9c5c5004c287a7d3c0ccec25749b00a0475726";
    hash = "sha256-kxqEn98tt+DFVGBZkuIR/9ncGTenaiOM5INAUj+tMtc=";
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
