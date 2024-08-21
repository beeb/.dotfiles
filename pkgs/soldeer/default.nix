{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "beeb";
    repo = "soldeer";
    rev = "49a645a70da674ef7e1c8a4aaedfd7cf84b2263a";
    hash = "sha256-8hAZOIUPVflkiFXso2u3O3Yn/Dgu1aJSs7ElWbP8rOs=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "cliclack-0.3.3" = "sha256-E/5+qPmcyXwtQWeLb9R2p9HBxSDgnO9AJq1/ofP5xEo=";
    };
  };


  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
