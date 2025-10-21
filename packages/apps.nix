{ pkgs, font, unstable_pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      r2modman
      unstable_pkgs.dolphin-emu
      calibre
      signal-desktop
      qbittorrent
      krita
      vlc
      spotify
      prismlauncher
      brave
      unstable_pkgs.zed-editor-fhs
      vesktop
      vscode
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
      gabutdm
      prusa-slicer
      bambu-studio
      pavucontrol
      openscad
      bottles
      netbeans
      element-desktop
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
      # themeFile = "gruvbox-dark";
    };
  };
}
