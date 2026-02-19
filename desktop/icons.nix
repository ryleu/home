{ pkgs, ... }:
let
  name = "Papirus-Dark";
  package = pkgs.papirus-icon-theme;
in
{
  gtk = {
    enable = true;

    iconTheme = {
      inherit name package;
    };

    gtk3.extraConfig.gtk-icon-theme-name = name;

    gtk4.extraConfig.Settings = "gtk-icon-theme-name=${name}";
  };
}
