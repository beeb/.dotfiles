{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "substreams";
  version = "1.1.10";

  src = fetchFromGitHub {
    owner = "streamingfast";
    repo = "substreams";
    rev = "v${version}";
    sha256 = "sha256-MuDlugCx6FXf2OSCb7+bJ4U8m8rdkgai6Pw+mcZN7QE=";
  };

  vendorHash = "sha256-2BmehVFRbMUsBto0XS1ENnUCC+Sx6HYaT01U7fMvSWE=";
  subPackages = [ "cmd/substreams" ];
  doCheck = false;

  meta = with lib; {
    description = "Powerful Blockchain streaming data engine, based on StreamingFast Firehose technology";
    homepage = "https://substreams.streamingfast.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ beeb ];
  };
}