{
  pkgs,
  font,
  cursor,
  ...
}:

{
  home = {
    packages = with pkgs; [
      hyprpolkitagent
      waybar
      grimblast
      wofi
      networkmanagerapplet
      libreoffice
      adwaita-qt6
      adwaita-qt
      glib
      gsettings-desktop-schemas
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
    ];

    pointerCursor = with cursor; {
      inherit name;
      inherit package;
      inherit size;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = font.sans.family + " 10";
      monospace-font-name = font.mono.family + " 10";
      color-scheme = pkgs.lib.mkDefault "prefer-dark";
    };
  };

  xdg = {
    portal = {
      enable = true;
      config = {
        common.default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };

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
