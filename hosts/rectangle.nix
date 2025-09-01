{ pkgs, ... }:

{
  services = {
    mako.settings.output = "DP-3";
  };

  home.packages = with pkgs; [
    davinci-resolve
    alvr
    vintagestory
  ];

  wayland.windowManager.hyprland = {
    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "DP-3,2560x1440@143.91Hz,0x0,1"
        "HDMI-A-1,1920x1080@74.97Hz,2560x-480,1,transform,3"
      ];
    };
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "dotnet-runtime-7.0.20"
    ];
  };
}
