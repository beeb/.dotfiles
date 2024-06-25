{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "soldeer";
  version = "0.2.15";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "v${version}";
    hash = "sha256-mpQ55mvXyGlWqnS1/83nxkD6cNy57NJ09qEahp55ymg=";
  };

  cargoHash = "sha256-jWqHR8h+pMa6d6H7IFTJWa/dqiFndY46kroK/2CZmyg=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
