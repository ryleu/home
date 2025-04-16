{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-code-nerdfont
    minecraftia
    unifont
  ];
}
