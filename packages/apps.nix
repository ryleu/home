{ pkgs, font, ... }:

{
  home = {
    packages = with pkgs; [
      calibre
      signal-desktop
      qbittorrent
      krita
      vlc
      spotify
      prismlauncher
      brave
      zed-editor
      vesktop
      vscode
      code-cursor
      (python312.withPackages (py: [
        py.numpy
        py.jupyter
        py.uv
        py.pip
        py.matplotlib
      ]))
      hugin
      qgis
      rstudio
      zotero
      logseq
      jetbrains.idea-community-src
      gabutdm
      prusa-slicer
      bambu-studio
      pavucontrol
      openscad
      bottles
    ];
  };

  programs = {
    firefox.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };

    zed-editor =
      let
        zedFontFeatures = builtins.listToAttrs (
          map (feature: {
            name = feature;
            value = true;
          }) font.mono.features
        );
      in
      {
        enable = true;
        extensions = [
          "git-firefly"
          "nix"
          "cargo-tom"
        ];
        userSettings = {
          assistant = {
            default_model = {
              provider = "copilot_chat";
              model = "claude-3-5-sonnet";
            };
            version = "2";
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          hour_format = "hour24";
          auto_update = false;
          vim_mode = true;
          ui_font_size = 16;
          theme = {
            mode = "dark";
            light = "One Light";
            dark = "Gruvbox Dark";
          };
          languages = {
            "Nix" = {
              language_servers = [
                "nixd"
                "nil"
              ];
            };
          };
          buffer_font_size = 16;
          buffer_font_family = font.mono.family;
          buffer_font_features = zedFontFeatures;
          terminal = {
            font_family = font.mono.family;
            font_features = zedFontFeatures;
            env = {
              "TERM" = "xterm-256color";
            };
          };
        };
      };

    kitty = {
      enable = true;
      font = {
        name = font.mono.family;
        size = 13;
      };
      settings = {
        disable_ligatures = "cursor";
        font_family =
          "family=\"${font.mono.family}\" features=\""
          + (builtins.concatStringsSep " +" font.mono.features)
          + "\"";
        notify_on_cmd_finish = "invisible";
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
      themeFile = "gruvbox-dark";
    };
  };

  services = {
    mako = {
      enable = true;
      settings = {
        actions = true;
        anchor = "top-right";
        backgroundColor = "#000000ff";
        borderColor = "#00ff99ee";
        textColor = "#ffffffff";
        borderRadius = 10;
        borderSize = 2;
        defaultTimeout = 3000;
      };
    };
  };
}
