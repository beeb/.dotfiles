{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "simple-completion-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "simple-completion-language-server";
    rev = "65fe65610567ff2c88dc975e03d82a85b48e71be";
    hash = "sha256-paHSoFqCHrP5foSLtzT6UGFRcnxe5vizHOGCaGiX04s=";
  };

  cargoHash = "sha256-nltW/s6fX9OTl4L78knw7jpKB+2qDveNP+FHzuugzBI=";

  doCheck = false;

  meta = {
    description = "Language server to enable word completion and snippets for Helix editor";
    homepage = "https://github.com/estin/simple-completion-language-server";
    mainProgram = "simple-completion-language-server";
  };
}
