{ pkgs, ... }:

let
  monoFont = "FiraCode Nerd Font";
  fontFeatures = [
    "liga"
    "calt"
    "cv01"
    "cv02"
    "cv04"
    "ss01"
    "ss06"
  ];
in
{
  home = {
    packages = with pkgs; [
      gnomeExtensions.appindicator
      hyprcursor
      waybar
      grimblast
      wofi
      phinger-cursors
      papirus-icon-theme
      networkmanagerapplet
      libreoffice
    ];

    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ monoFont ];
    };
  };

  qt = {
    enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "phinger-cursors-light";
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
  };
}
