{ pkgs, ... }:

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
in
{
  home = {
    packages = with pkgs; [
      krita
      vlc
      spotify
      prismlauncher
      brave
      zed-editor
      vesktop
      vscode
      (python312.withPackages (ps: [
        ps.numpy
        ps.jupyter
        ps.uv
        ps.pip
        ps.matplotlib
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
          }) fontFeatures
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
            mode = "system";
            light = "One Light";
            dark = "One Dark";
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
          buffer_font_family = monoFont;
          buffer_font_features = zedFontFeatures;
          terminal = {
            font_family = monoFont;
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
        name = monoFont;
        size = 13;
      };
      settings = {
        disable_ligatures = "cursor";
        font_family =
          "family=\"${monoFont}\" features=\"" + (builtins.concatStringsSep " +" fontFeatures) + "\"";
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
}
