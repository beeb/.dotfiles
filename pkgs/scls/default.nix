{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "simple-completion-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "simple-completion-language-server";
    rev = "6c508fffc428f7080e82ec6baee0789e5aa5cf7c";
    hash = "sha256-sKe0IS++OAPbewSrwDBFDRgmVp8w8dJ5dNibMgKTupo=";
  };

  cargoHash = "sha256-ujuZNyBdei0Djzv1baTTfsnGULKHY8ramtflQf+mLi4=";

  doCheck = false;

  meta = {
    description = "Language server to enable word completion and snippets for Helix editor";
    homepage = "https://github.com/estin/simple-completion-language-server";
    mainProgram = "simple-completion-language-server";
  };
}
