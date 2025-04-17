{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
    vlc
    spotify
    prismlauncher
    brave
    zed-editor
    vesktop
    vscode
    rstudio
    zotero
    logseq
    jetbrains.idea-community-src
    gabutdm
    prusa-slicer
    bambu-studio
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
  };
}
