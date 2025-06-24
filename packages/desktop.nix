{ pkgs, font, ... }:

{
  home = {
    packages = with pkgs; [
      waybar
      grimblast
      wofi
      networkmanagerapplet
      libreoffice
      adwaita-qt6
      adwaita-qt
    ];
  };

  # TODO: figure out why this breaks the cursor theme on rectangle
  #   pointerCursor = {
  #     name = "phinger-cursors-light";
  #     package = pkgs.phinger-cursors;
  #     size = 24;
  #     gtk.enable = true;
  #     x11.enable = true;
  #   };
  # };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        font.mono.family
      ];
      sansSerif = [
        font.sans.family
        font.fallback
      ];
      serif = [
        font.serif.family
        font.fallback
      ];
      emoji = [
        font.emoji.family
        font.fallback
      ];
    };
  };

  qt = {
    enable = true;

    kde.settings = { };

    platformTheme.name = "adwaita";

    style = {
      name = "adwaita-dark";
    };
  };
}
