{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      astal,
      ags,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.stdenvNoCC.mkDerivation rec {
        name = "ryleu-astal";
        src = ./.;

        nativeBuildInputs = [
          ags.packages.${system}.default
          pkgs.wrapGAppsHook
          pkgs.gobject-introspection
        ];

        buildInputs = (
          with astal.packages.${system};
          [
            astal3
            gjs

            # plugins
            battery
            hyprland
            mpris
            network
            tray
            wireplumber
          ]
        );

        installPhase = ''
          mkdir -p $out/bin
          ags bundle app.ts $out/bin/${name}
          chmod +x $out/bin/${name}
        '';
      };
    };
}
