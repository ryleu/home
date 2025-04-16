{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    hyprcursor
    waybar
    grimblast
    wofi
    phinger-cursors
    papirus-icon-theme
    networkmanagerapplet
  ];
}
