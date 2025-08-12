{ lib, ... }:

{
  services.mako.settings.output = "eDP-1";

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080@60.04200Hz, 0x0, 1"
      ", preferred, auto, 1"
    ];
    workspace = [
      "1, eDP-1"
      "10, HDMI-A-1"
    ];

    # save battery
    decoration = {
      blur.enabled = lib.mkForce false;
      shadow.enabled = lib.mkForce false;
    };
  };
}
