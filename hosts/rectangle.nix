{ pkgs, ... }:

{
  services = {
    mako.settings.output = "DP-3";

    hyprpaper = let
      monitor1 = "/home/ryleu/.config/home-manager/wallpaper/wallpaper_monitor_1.png";
      monitor2 = "/home/ryleu/.config/home-manager/wallpaper/wallpaper_monitor_2.png";
    in {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ 
          "${monitor1}"
          "${monitor2}"
        ];

        wallpaper = [
          "DP-3,${monitor1}"
          "HDMI-A-1,${monitor2}"
        ];
      };
    };
  };

  home.packages = with pkgs; [
    alvr
  ];

  wayland.windowManager.hyprland = {
    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "DP-3,2560x1440@143.91Hz,0x0,1"
        "HDMI-A-1,1920x1080@74.97Hz,-1080x-480,1,transform,1"
      ];
    };
  };
}
