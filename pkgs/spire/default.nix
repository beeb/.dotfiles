{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "spire";
  version = "0.22.6";

  src = fetchFromGitHub {
    owner = "chronicleprotocol";
    repo = "oracle-suite";
    rev = "v${version}";
    sha256 = "sha256-kuDmVn7HeLdLRwPb/mGeUc4kX2m3q0oUVfLWWOSCpnI=";
  };

  vendorHash = "sha256-A1HxvK97huOI+sgRghtwjvgSX8QduFCVWVS+ub39L6A=";
  subPackages = [ "cmd/spire" ];
  doCheck = false;

  meta = with lib; {
    description = "A peer-to-peer node & client for broadcast signed asset prices";
    homepage = "https://chroniclelabs.org";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ beeb ];
  };
}
