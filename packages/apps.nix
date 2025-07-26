{ pkgs, font, unstable_pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      unstable_pkgs.dolphin-emu
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
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
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
        background-color = "#282828FF";
        border-color = "#00FF99FF";
        text-color = "#EBDBB2FF";
        border-radius = 10;
        border-size = 2;
        default-timeout = 3000;
      };
    };
  };
}
