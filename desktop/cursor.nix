{ pkgs, ... }:
let
  name = "phinger-cursors-light";
  package = pkgs.phinger-cursors;
  size = 32;
in
{
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor '${name}' ${builtins.toString size}"
  ];

  home.sessionVariables = {
    XCURSOR_SIZE = size;
    HYPRCURSOR_SIZE = size;
  };

  home.pointerCursor = {
    enable = true;
    inherit package;
    dotIcons.enable = true;
    gtk.enable = true;
    hyprcursor = {
      enable = true;
      inherit size;
    };
    inherit name;
    inherit size;
    x11.enable = true;
  };
}
