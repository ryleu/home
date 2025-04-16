{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
}
