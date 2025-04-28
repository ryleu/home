{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-code-nerdfont
    minecraftia
    unifont
    source-code-pro
    corefonts
    vistafonts
    comic-mono
    comic-neue
    font-awesome
  ];
}
