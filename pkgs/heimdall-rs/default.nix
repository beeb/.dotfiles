{ fetchFromGitHub
, rustPlatform
, openssl
, pkg-config
}:

rustPlatform.buildRustPackage {
  pname = "heimdall-rs";
  version = "0.8.4";

  src = fetchFromGitHub {
    owner = "Jon-Becker";
    repo = "heimdall-rs";
    rev = "5517ba7032fc155b945465b1419af91fddc58489";
    hash = "sha256-J4EJs0aONFEuL2ZvdnNUXVOcb3BaXqxKK/aTuGcfV/E=";
  };

  cargoHash = "sha256-PjPdUpb9t+70PaR9ITPTNSdsA7qD4vw9kZjD/eP05CI=";

  doCheck = false;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    description = "Advanced EVM smart contract toolkit specializing in bytecode analysis and extracting information from unverified contracts";
    homepage = "https://github.com/Jon-Becker/heimdall-rs";
    mainProgram = "heimdall";
  };
}
