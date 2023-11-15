{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "bulloak";
  version = "0.5.3";

  src = fetchFromGitHub {
    owner = "alexfertel";
    repo = "bulloak";
    rev = "d2f49efba30ba919e62762af00c577b9bc1676c5";
    hash = "sha256-7CdS5melxqGlq3ued9Z+LS93H5Av932FV/vRtBVgZjg=";
  };

  cargoHash = "sha256-mqu+KOgKSy06wcC37kwo/AC5KyegyuzGX0oBsXBXngw=";

  cargoPatches = [
    ./add-Cargo.lock.patch
  ];

  doCheck = false;

  meta = with lib; {
    description = "A Solidity test generator based on the Branching Tree Technique";
    homepage = "https://github.com/alexfertel/bulloak";
    license = with licenses; [ mit asl20 ];
    maintainers = with maintainers; [ beeb ];
  };
}
