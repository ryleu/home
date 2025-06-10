{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
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
