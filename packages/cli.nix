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
    wl-clipboard
    fastfetch
    htop
    nvtopPackages.full
    eza
    aria2
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
