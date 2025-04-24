{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
  }; # end wayland.windowManager.sway
}
