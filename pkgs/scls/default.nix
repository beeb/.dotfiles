{ fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "simple-completion-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "simple-completion-language-server";
    rev = "ccf0975e1509f8ec4d758f28561db54fd8816cf6";
    hash = "sha256-st6HvFWJMvwrg0zz1scn2wZVBQZX0Au2UkMwD15O7bs=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-nannF4BKRLCcsS7VznzEHqrhLHYvN4X22t8jud87XEM=";

  doCheck = false;

  meta = {
    description = "Language server to enable word completion and snippets for Helix editor";
    homepage = "https://github.com/estin/simple-completion-language-server";
    mainProgram = "simple-completion-language-server";
  };
}
