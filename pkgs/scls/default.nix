{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "simple-completion-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "simple-completion-language-server";
    rev = "a3222a996f803dfa8f18744b5047b826648db140";
    hash = "sha256-g3fsztKOrDnIJ2PB/3ULhNenJ5FeAChOu8Nvjb/bLHk=";
  };

  cargoHash = "sha256-6TruW8gb87tO1TWvgb3QsczB1fp+5KvgENSOunq4M2E=";

  doCheck = false;

  meta = {
    description = "Language server to enable word completion and snippets for Helix editor";
    homepage = "https://github.com/estin/simple-completion-language-server";
    mainProgram = "simple-completion-language-server";
  };
}
