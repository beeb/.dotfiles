{ lib
, rustPlatform
, fetchFromGitHub
, nix-update-script
,
}:

rustPlatform.buildRustPackage rec {
  pname = "harper";
  version = "0.49.0";

  src = fetchFromGitHub {
    owner = "Automattic";
    repo = "harper";
    rev = "v${version}";
    hash = "sha256-9GmsfRsSWw9t+xlR/MddLvzUyGhHv2q4eK/QA/F8OuI=";
  };

  buildAndTestSubdir = "harper-ls";
  useFetchCargoVendor = true;
  cargoHash = "sha256-r8JZ2toHQHBVtgjwxr6Mzlm6O89dQiLG6+9BojbQ1/A=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Grammar Checker for Developers";
    homepage = "https://github.com/Automattic/harper";
    license = lib.licenses.asl20;
    mainProgram = "harper-ls";
  };
}
