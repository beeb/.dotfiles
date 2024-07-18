{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "soldeer";
  version = "0.2.19";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "v${version}";
    hash = "sha256-lA+ZvB5tjJzfLozUfzNCb/O7kvVb5F7yLxKOMPRIWlU=";
  };

  cargoHash = "sha256-G60TDJDrL6+jXxsAq/ghYn2I5j5MN1PY9WFa0+h69jg=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
