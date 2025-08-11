{ pkgs, unstable_pkgs, ... }:

{
  home.packages = with pkgs; [
    slack
    dbeaver-bin
    unstable_pkgs.code-cursor-fhs
    mongodb-compass
  ];
}
