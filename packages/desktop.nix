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
    ];

    pointerCursor = with cursor; {
      inherit name;
      inherit package;
      inherit size;
      gtk.enable = true;
      x11.enable = true;
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
