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
    rustc
    rustfmt
    nix-search
    nixfmt-rfc-style
    ffmpeg-full
    wl-clipboard
    fastfetch
    htop
    nvtopPackages.full
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
