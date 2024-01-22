{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "roundme";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "crytic";
    repo = "roundme";
    rev = "${version}";
    hash = "sha256-q5cSZoaVZ6noyOoOGcxPW8FuqCBAl6WmLMWqnUczGI0=";
  };

  cargoHash = "sha256-rgFz4b274zhClc293EoZEVqC6nzs1H8i4E+znbBjXRs=";

  doCheck = false;

  meta = with lib; {
    description = "Human-assisted rounding analyzer";
    homepage = "https://github.com/crytic/roundme";
    license = with licenses; [ agpl3Only ];
    maintainers = with maintainers; [ beeb ];
    mainProgram = "roundme";
  };
}
