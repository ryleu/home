{ config, pkgs, ... }:

{
  imports = [
    "${
      fetchTarball {
        url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
        sha256 = "sha256:09j4kvsxw1d5dvnhbsgih0icbrxqv90nzf0b589rb5z6gnzwjnqf";
      }
    }/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}
