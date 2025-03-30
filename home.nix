{ config, pkgs, ... }:

let
  monoFont = "FiraCode Nerd Font";
  fontFeatures = [
    "liga"
    "calt"
    "cv01"
    "cv02"
    "cv04"
    "ss01"
    "ss06"
  ];
in {
  home = {
    username = "ryleu";
    homeDirectory = "/home/ryleu";
    stateVersion = "24.11"; # do not change without first properly migrating your setup!

    packages = with pkgs; [
      # desktop
      gnomeExtensions.appindicator
      hyprcursor
      waybar
      grimblast
      wofi
      phinger-cursors
      papirus-icon-theme
      networkmanagerapplet

      # fonts
      fira-code-nerdfont
      minecraftia

      # development
      gh
      vim
      nix-index
      nixd
      nil
      wget
      cargo
      rustc
      rustfmt

      # apps
      spotify
      prismlauncher
      brave
      zed-editor
      vesktop
      vscode
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager.
    sessionVariables = {
      EDITOR = "vim";
    };

    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  fonts.fontconfig.enable = true;

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

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      exec-once = [
        "nm-applet &"
        "waybar &"
      ];

      # See https://wiki.hyprland.org/Configuring/Environment-variables/
      # env = {
      #   XCURSOR_SIZE = "24";
      #   HYPRCURSOR_SIZE = "24";
      # };

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 5;
        gaps_out = 20;

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
        pseudotile = true;
        preserve_split = true;
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
      bind = let genKeybinds = n:
        if n > 10 then [ ]
        else let
          key = toString n;
          num = if key == 0 then "10"
          else key;
        in [
          # Switch workspaces with mainMod + [0-9]
          "\$mainMod, ${key}, workspace, ${num}"
          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "\$mainMod SHIFT, ${key}, movetoworkspacesilent, ${num}"
        ] ++ genKeybinds (n + 1);
      in [
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

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # grimblast
        ", PRINT, exec, grimblast --notify copysave output ~/Pictures"
        "SUPER, PRINT, exec, grimblast --notify copysave screen ~/Pictures"
        "SHIFT, PRINT, exec, grimblast --notify copysave area ~/Pictures"
        "CTRL, PRINT, exec, grimblast --notify copysave active ~/Pictures"
      ] ++ genKeybinds 0; # end bind

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

  gtk = {
    enable = true;
    cursorTheme = {
      name = "phinger-cursors-light";
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
  };

  programs = {
    kitty = {
      enable = true;
      font = {
        name = monoFont;
        size = 13;
      };
      settings = {
        disable_ligatures = "cursor";
        font_family =
          "family=\"${monoFont}\" features=\""
          + (builtins.concatStringsSep " +" fontFeatures)
          + "\"";
      };
    };

    ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        font-size = 13;
        font-family = [
          ""
          monoFont
        ];
        font-feature = fontFeatures;
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user = {
          signingkey = "~/.ssh/github.pub";
          email = "69326171+ryleu@users.noreply.github.com";
          name = "ryleu";
        };
        core.editor = "vim";
        init.defaultBranch = "main";
      };
    };

    bash = {
      enable = true;
      bashrcExtra = ''
        export EDITOR="vim"
      '';
    };

    starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
