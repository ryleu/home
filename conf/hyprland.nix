{ pkgs, cursor, ... }:

let
  wallpaperPath = "/home/ryleu/.config/home-manager/wallpaper/luca-bravo.jpg";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = pkgs.lib.mkDefault [
        ", preferred, auto, 1"
      ];

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi --show drun";
      "$touchpadScript" =
        ''bash -c 'if hyprctl getoption input:touchpad:disable_while_typing | grep -q "int: 1"; then hyprctl keyword input:touchpad:disable_while_typing false ; else hyprctl keyword input:touchpad:disable_while_typing true ; fi' '';

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      exec-once = [
        "nm-applet"
        "blueman-applet"
        "systemctl --user restart waybar.service"
        "systemctl --user restart hypridle.service"
        "systemctl --user restart hyprpaper.service"
        "systemctl --user restart hyprpolkitagent.service"
        "hyprctl setcursor '${cursor.name}' ${builtins.toString cursor.size}"
      ];

      # See https://wiki.hyprland.org/Configuring/Environment-variables/

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 3;
        gaps_out = 12;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        # has to be quoted because of a certified Krill Issue (tm) on the part of the hypr devs
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      }; # end general

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;
        # rounding_power = 2; # supported on latest git, not yet in nixpkgs

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 3;

          vibrancy = 0.1696;
        };
      }; # end decoration

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      }; # end animations

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = false;
        preserve_split = false;
        force_split = 2;
        split_width_multiplier = 1.778; # 16:9
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = false;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
          tap-to-click = true;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = true;
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      # device = {
      #     name = "epic-mouse-v1";
      #     sensitivity = -0.5;
      # };

      # See https://wiki.hyprland.org/Configuring/Keywords/
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

      # See https://wiki.hyprland.org/Configuring/Binds/ for more
      bind =
        let
          genKeybinds =
            n: # n will go 1 -> 10
            if n > 10 then
              [ ]
            else
              let
                # for each of those 1 -> 10 we need to figure out the corresponding workspace and key
                workspace = toString n;
                # the workspace is just toString n, but we need key 0 to map to workspace 10
                key = if workspace == "10" then "0" else workspace;
              in
              [
                # now for the actual keybinds
                # Switch workspaces with mainMod + [0-9]
                "$mainMod, ${key}, workspace, ${workspace}"
                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, ${key}, movetoworkspacesilent, ${workspace}"
              ]
              ++ genKeybinds (n + 1); # and finally the recursion where we concat the next number up
        in
        [
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod SHIFT, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, M, fullscreen, 1"
          "$mainMod, F, fullscreen, 0"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, J, togglesplit," # dwindle
          "$mainMod SHIFT, L, exec, hyprlock --immediate"
          "$mainMod, T, exec, $touchpadScript" # Add this line

          # Move focus with mainMod + H J K L
          "$mainMod, H, movefocus, l"
          "$mainMod, J, movefocus, d"
          "$mainMod, K, movefocus, u"
          "$mainMod, L, movefocus, r"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # grimblast
          ", PRINT, exec, grimblast --notify copysave output ~/Pictures"
          "SUPER, PRINT, exec, grimblast --notify copysave screen ~/Pictures"
          "SHIFT, PRINT, exec, grimblast --notify copysave area ~/Pictures"
          "CTRL, PRINT, exec, grimblast --notify copysave active ~/Pictures"
        ]
        ++ genKeybinds 1; # call the function to generate keybinds for workspaces 1 -> 10

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Requires playerctl
      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules
      windowrule = [
        # Example windowrule
        # windowrule = float,class:^(kitty)$,title:^(kitty)$

        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    }; # end settings
  }; # end wayland.windowManager.hyprland

  programs = {
    hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
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

  services = {
    hypridle = {
      enable = true;

      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "hyprlock";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      }; # end settings
    }; # end hypridle

    hyprpaper = pkgs.lib.mkDefault {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [
          "${wallpaperPath}"
        ];

        wallpaper = [
          ",${wallpaperPath}"
        ];
      };
    };
  }; # end services
}
