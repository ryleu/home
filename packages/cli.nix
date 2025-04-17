{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
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
    python314
    wl-clipboard
    fastfetch
    htop
    nvtopPackages.full
    eza
  ];
}
