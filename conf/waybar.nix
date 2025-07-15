{ font, ... }:

let
  fa = text: "<span font_family='Font Awesome 6 Free'>${text}</span>";

  style = builtins.readFile ./waybar.css;
  formattedStyle = builtins.replaceStrings [ "\${fontFamily}" ] [ "\"${font.mono.family}\"" ] style;
in
{
  home.file.".config/waybar/style.css".text = formattedStyle;

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        postition = "top";
        height = 26;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "battery"
          "backlight"
          "cpu"
          "pulseaudio"
          "clock"
          "keyboard-state"
          "tray"
        ];

        "hyprland/workspaces" = {
          all-outputs = true;
        };

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          markup = "pango";
          format = "{name} {icon}";
          format-icons = {
            locked = fa "";
            unlocked = fa "";
          };
        };

        "tray" = {
          spacing = 10;
        };

        "clock" = {
          format = "{:%R %Z}";
          format-alt = "{:%R %Y-%m-%d %Z}";
          tooltip-format = "<big>{:%A, %B %d}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "clock: calendar" = {
          mode = "month";
          weeks-pos = "";
        };
        "clock: calendar: format" = {
          months = "";
          days = "";
          weeks = "{:%U}";
          weekdays = "";
          today = "<b><u>{}</b></u>";
        };

        "cpu" = {
          format = "{usage}% " + fa "";
          tooltip = false;
        };

        "backlight" = {
          format = "{percent}% {icon}";
          tooltip-format = "{percent}% brightness";
          format-icons = [
            (fa "")
            (fa "")
            (fa "")
            (fa "")
            (fa "")
            (fa "")
            (fa "")
            (fa "")
            (fa "")
          ];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            (fa "")
            (fa "")
            (fa "")
            (fa "")
            (fa "")
          ];
        };

        "pulseaudio" = {
          # scroll-step = 1; # %, can be a float
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}" + fa "" + " {format_source}";
          format-bluetooth-muted = fa "" + " {icon}" + fa "" + " {format_source}";
          format-muted = fa "" + " {format_source}";
          format-source = "{volume}% " + fa "";
          format-source-muted = fa "";
          format-icons = {
            headphone = fa "";
            hands-free = fa "";
            headset = fa "";
            phone = fa "";
            portable = fa "";
            car = fa "";
            default = [
              (fa "")
              (fa "")
              (fa "")
            ];
          };
          on-click = "pavucontrol";
        }; # end pulseaudio

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = fa "";
            deactivated = fa "";
          };
        };
      }; # end mainBar
    }; # end settings
  }; # end programs.waybar
}
