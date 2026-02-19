{ pkgs, ... }:
let
  name = "Bibata-Modern-Ice";
  package = pkgs.bibata-cursors;
  size = 32;
in
{
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
