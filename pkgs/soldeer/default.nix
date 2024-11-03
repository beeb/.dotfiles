{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "v0.4.1";
    hash = "sha256-PEgzJc5zIbsI9edfrABpiyzrzhP4b4VdkapoKt/NROk=";
  };

  cargoHash = "sha256-Gar/RCtxYxO4DXAen3nGRPcGPKlqMVbqz3OYEp/VTdo=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
