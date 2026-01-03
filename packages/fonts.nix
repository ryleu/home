{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    minecraftia
    unifont
    source-code-pro
    corefonts
    comic-mono
    comic-neue
    font-awesome
    noto-fonts
    rubik
    corefonts
    vista-fonts
    carlito
  ];
}
