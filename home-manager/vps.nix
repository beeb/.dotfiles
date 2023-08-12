{ pkgs, ... }:
{
  home.username = "beeb";
  home.homeDirectory = "/home/beeb";

  home.packages = with pkgs; [
    (python39.withPackages (ps: with ps; [ cython ]))
    poetry
  ];
}
