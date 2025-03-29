{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "DP-2,2560x1440@143.91Hz,0x0,1"
        "HDMI-A-1,1920x1080@74.97Hz,2560x-480,1,transform,3"
      ];
    };
  };
}
