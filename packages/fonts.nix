{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-code-nerdfont
    minecraftia
    unifont
    source-code-pro
  ];
}
