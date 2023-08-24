{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "substreams";
  version = "1.1.11";

  src = fetchFromGitHub {
    owner = "streamingfast";
    repo = "substreams";
    rev = "v${version}";
    sha256 = "sha256-vibbkUBNozs7kDW8Z9428YEa+RgaDz4yoYSn+sBjivI=";
  };

  vendorHash = "sha256-Ibb4VfVj3PsyGgRrIwd+92t4D8ui9sFwTrXtopv+mnE=";
  subPackages = [ "cmd/substreams" ];
  doCheck = false;

  meta = with lib; {
    description = "Powerful Blockchain streaming data engine, based on StreamingFast Firehose technology";
    homepage = "https://substreams.streamingfast.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ beeb ];
  };
}
