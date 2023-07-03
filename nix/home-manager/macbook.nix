{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pinentry
  ];
}
