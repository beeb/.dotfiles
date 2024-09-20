{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "bf645f44b1ab3919133c7e335f5cc9cf8d2eb4b2";
    hash = "sha256-BnIPeUM277+Q9q469ZnO19ai4gq1ClfjCNxkSCUntVU=";
  };

  cargoHash = "sha256-frKRAaBm/KAzJKeuX8AhUWvE1d7iUEGZHr9RCfAv+PU=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
