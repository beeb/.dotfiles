{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mario-eth";
    repo = "soldeer";
    rev = "13412f1137ef5bea970deec5517c1e970c065d2a";
    hash = "sha256-+cCvQesFknRvZmNjf7QTBn7dL3JwfUC2f9sBi5ANPe4=";
  };

  cargoHash = "sha256-t1qO0W2GX24G1WBMRfSITdPQTdqKe959eNh08Hkrs3c=";

  doCheck = false;

  meta = {
    description = "Solidity Package Manager written in rust";
    homepage = "https://soldeer.xyz";
    mainProgram = "soldeer";
  };
}
