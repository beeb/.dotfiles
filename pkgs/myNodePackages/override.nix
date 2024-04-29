{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
}:

let
  nodePackages = import ./default.nix {
    inherit pkgs system;
  };
in
nodePackages // {
  "@nomicfoundation/solidity-language-server" = nodePackages."@nomicfoundation/solidity-language-server".override {
    preRebuild = ''
      ${pkgs.nodejs_20}/bin/npm install --save @nomicfoundation/slang-linux-x64-gnu
    '';
  };
}
