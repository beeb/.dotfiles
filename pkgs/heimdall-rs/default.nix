{ fetchFromGitHub
, rustPlatform
, openssl
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "heimdall-rs";
  version = "0.8.4";

  src = fetchFromGitHub {
    owner = "Jon-Becker";
    repo = "heimdall-rs";
    rev = "${version}";
    hash = "sha256-+hIcnCiBEI/Nokvsm+/x6TP3+G15hFqjF62rJDRGbqQ=";
  };

  cargoHash = "sha256-QcMqqxzFF7COJ5osegU3MG2uMjNl7yb11DOaE5Jey4g=";

  doCheck = false;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    description = "Advanced EVM smart contract toolkit specializing in bytecode analysis and extracting information from unverified contracts";
    homepage = "https://github.com/Jon-Becker/heimdall-rs";
    mainProgram = "heimdall";
  };
}
