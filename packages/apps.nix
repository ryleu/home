{ pkgs, font, unstable_pkgs, master_pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      qdirstat
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
      vscode-fhs
      (python312.withPackages (py: [
        py.bpython
	ncurses
        py.numpy
        py.jupyter
        py.uv
        py.pip
        py.matplotlib
      ]))
      hugin
      qgis
      logseq
      gabutdm
      prusa-slicer
      orca-slicer
      bambu-studio
      pavucontrol
      openscad
      bottles
      element-desktop
      picard
      master_pkgs.stoat-desktop
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
    };
  };
}
