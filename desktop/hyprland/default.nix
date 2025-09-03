{
  pkgs,
  cursor,
  ...
}:
{
  imports = [
    ./colors.nix
    ./animations.nix
    ./decoration.nix
    ./power-management.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = pkgs.lib.mkDefault [
        ", preferred, auto, 1"
      ];

      # Set programs that you use
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$touchpadScript" =
        ''bash -c 'if hyprctl getoption input:touchpad:disable_while_typing | grep -q "int: 1"; then hyprctl keyword input:touchpad:disable_while_typing false ; else hyprctl keyword input:touchpad:disable_while_typing true ; fi' '';

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      exec-once = [
        "systemctl --user restart hyprpolkitagent.service"
        "hyprctl setcursor '${cursor.name}' ${builtins.toString cursor.size}"
      ];

      # See https://wiki.hyprland.org/Configuring/Environment-variables/

      env = [
        "XCURSOR_SIZE,${builtins.toString cursor.size}"
        "HYPRCURSOR_SIZE,${builtins.toString cursor.size}"
      ];

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = false;
        preserve_split = false;
        force_split = 2;
        split_width_multiplier = 1.5; # 16:9
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        middle_click_paste = false;
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
        accel_profile = "adaptive";
        sensitivity = 0.2; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
          tap-to-click = true;
        };

      };
      device = [
        {
          name = "logitech-optical-usb-mouse";
          sensitivity = 1.0;
        }
      ];

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = true;
      };

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

          # caelestia stuff
          "$mainMod, R, global, caelestia:showall"

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
}
