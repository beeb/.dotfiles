{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "978478d2ad5e16f13ebb38d6a1eb99fcc6b09c7a";
    hash = "sha256-+G/sSo48WMoK23v1vRPfMyiD0wwK5BCUnL7qX3Wvuis=";
  };

  cargoHash = "sha256-vRlBmAX/Q9DrGWfDTb85M1n3Gqg5MCEQvfBSraTm5IQ=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
