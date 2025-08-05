{ ... }:

{
  imports = [
    "${
      fetchTarball {
        url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
        sha256 = "sha256:1rdn70jrg5mxmkkrpy2xk8lydmlc707sk0zb35426v1yxxka10by";
      }
    }/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}
