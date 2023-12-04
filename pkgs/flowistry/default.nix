{ lib
, fetchCrate
, rustPlatform
, rustc
}:

rustPlatform.buildRustPackage rec {
  pname = "flowistry_ide";
  version = "0.5.41";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-dfBby7TRiYyLP9H1I9xrd/ZXvmJ00MF5GzKoRVm9BCY=";
  };

  cargoHash = "sha256-JTKLyVDKCEKMLzEO2sd4mU+3U/bLprmPtqR2mm1esbs=";

  doCheck = false;

  # requires nightly toolchain
  RUSTC_BOOTSTRAP = 1;

  buildInputs = [ rustc.llvm ];

  meta = with lib; {
    description = "An IDE plugin for Rust that helps you focus on relevant code. ";
    homepage = "https://github.com/willcrichton/flowistry";
    license = licenses.mit;
    mainProgram = "cargo-flowistry";
    maintainers = with maintainers; [ beeb ];
  };
}
