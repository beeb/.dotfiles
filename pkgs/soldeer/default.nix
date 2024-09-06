{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "940039cb39742c95408b3a7047739c0140842dcd";
    hash = "sha256-vxq6GqT+ecr6NptS37I20Eh4U7ry52wwnYQ+nEhZAfU=";
  };

  cargoHash = "sha256-t1qO0W2GX24G1WBMRfSITdPQTdqKe959eNh08Hkrs3c=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
