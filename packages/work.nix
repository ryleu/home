{ pkgs, font, ... }:

{
  home.packages = with pkgs; [
    slack
    dbeaver-bin
    code-cursor
    mongodb-compass
  ];
}
