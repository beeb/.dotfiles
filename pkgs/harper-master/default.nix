{ lib
, rustPlatform
, fetchFromGitHub
, nix-update-script
,
}:

rustPlatform.buildRustPackage {
  pname = "harper";
  version = "0.44.0-main";

  src = fetchFromGitHub {
    owner = "Automattic";
    repo = "harper";
    rev = "7d9375b22df65ab9cbd09130f52a88d358001a06";
    hash = "sha256-MGItL/k78V9LKBBH37dAJq9cAJUWv+Ut7MLZgd+3+lg=";
  };

  buildAndTestSubdir = "harper-ls";
  useFetchCargoVendor = true;
  cargoHash = "sha256-tuCxWvZ74DtLRiEO4tX2KpRk22gKgVjsZTmMY1BzF7E=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Grammar Checker for Developers";
    homepage = "https://github.com/Automattic/harper";
    license = lib.licenses.asl20;
    mainProgram = "harper-ls";
  };
}
