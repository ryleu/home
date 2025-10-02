{ pkgs, ... }:

{
  home.packages = with pkgs; [
    undollar
    silver-searcher
    ripgrep
    bun
    unzip
    jq
    gh
    please-cli
    nix-index
    nixd
    nil
    wget
    cargo
    gcc
    rustc
    rustfmt
    nix-search
    nixfmt-rfc-style
    ffmpeg-full
    wl-clipboard
    fastfetch
    htop
    eza
    aria2
    tmux
    packwiz
  ];

  programs = {
    chawan = {
      enable = true;
      settings = {
        buffer = {
          images = true;
        };
      };
    };
  };
}
