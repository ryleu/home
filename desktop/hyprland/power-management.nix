{ pkgs, ... }:
{
  # This file handles power management and auto locking

  services = {
    hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock --immediate";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 120; # 2 minutes
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 300; # 5 minutes
            on-timeout = "bash -c 'playerctl -a status 2>/dev/null || systemctl suspend'";
          }
        ];
      };
    }; # end hypridle
  }; # end services

  programs = {
    hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          grace = 60;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "~/Pictures/Wallpapers/bg.png";
            blur_passes = 3;
            blur_size = 4;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "<span foreground=\"##cad3f5\">Password...</span>";
            shadow_passes = 2;
          }
        ];
      };
    }; # end hyprlock
  }; # end programs

  home.packages = with pkgs; [
    playerctl
  ];
}
