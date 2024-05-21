{ fetchFromGitHub
, rustPlatform
, openssl
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "heimdall-rs";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "Jon-Becker";
    repo = "heimdall-rs";
    rev = version;
    hash = "sha256-F1bhgUkgH6dHOTiCzpNksDMS9p6aX0cogtQZbKoKFHg=";
  };

  cargoHash = "sha256-Yr/eT9+bdcQHhozojLRcDIlwdcxpVEp0m7oDd6DScXE=";

  doCheck = false;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    description = "Advanced EVM smart contract toolkit specializing in bytecode analysis and extracting information from unverified contracts";
    homepage = "https://github.com/Jon-Becker/heimdall-rs";
    mainProgram = "heimdall";
  };
}
