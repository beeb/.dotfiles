{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "soldeer";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "beeb";
    repo = "soldeer";
    rev = "3f6cbd549fdbd8059b5151ff7300c9a91b3a2f4e";
    hash = "sha256-ixhZ1OFckiQVUAho16r0MrmLrD/po/QxWxUPwfTmduU=";
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
