{ ... }:

{
  imports = [
    "${
      fetchTarball {
        url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
        sha256 = "sha256:1l77kybmghws3y834b1agb69vs6h4l746ga5xccvz4p1y8wc67h7";
      }
    }/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}
