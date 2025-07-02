{ lib
, rustPlatform
, fetchFromGitHub
, nix-update-script
,
}:

rustPlatform.buildRustPackage {
  pname = "harper";
  version = "0.47.0";

  src = fetchFromGitHub {
    owner = "Automattic";
    repo = "harper";
    rev = "v0.47.0";
    hash = "sha256-kVZG3Vfe+PABhrXY26AUlBxrpiL9UtmIka84s0yvsXI=";
  };

  buildAndTestSubdir = "harper-ls";
  useFetchCargoVendor = true;
  cargoHash = "sha256-M6HdwQZanMxTvDdw0giycoSJmaMVfGI8Vg9NjdYJaak=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Grammar Checker for Developers";
    homepage = "https://github.com/Automattic/harper";
    license = lib.licenses.asl20;
    mainProgram = "harper-ls";
  };
}
