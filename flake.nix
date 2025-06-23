{
  description = "Home Manager configuration of ryleu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      # Helper to generate package sets for a given system.
      pkgsFor = system: {
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = nixpkgs-unstable.legacyPackages.${system};
      };

      amd64 = pkgsFor "x86_64-linux";
      arm64 = pkgsFor "aarch64-linux";

      # Helper to generate a home-manager configuration.
      mkHome =
        {
          pkgs,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.pkgs;
          extraSpecialArgs = {
            font = {
              mono = {
                family = "FiraCode Nerd Font";
                features = [
                  "liga"
                  "calt"
                  "cv01"
                  "cv02"
                  "cv04"
                  "ss01"
                  "ss06"
                ];
              };
              sans = {
                family = "Noto Sans";
                features = [ ];
              };
              serif = {
                family = "Noto Serif";
                features = [ ];
              };
            };

            unstable_pkgs = pkgs.unstable;
          };
          inherit modules;
        };

      baseModules = [
        ./home.nix
        ./conf/ssh.nix
        ./packages/cli.nix
      ];
      guiModules = baseModules ++ [
        ./conf/hyprland.nix
        ./conf/waybar.nix
        ./conf/sway.nix
        ./packages/apps.nix
        ./packages/desktop.nix
        ./packages/fonts.nix
      ];
    in
    {
      homeConfigurations = {
        "ryleu@barely-better" = mkHome {
          pkgs = amd64;
          modules = guiModules ++ [
            ./hosts/laptop.nix
          ];
        };
        "ryleu@mathrock" = mkHome {
          pkgs = amd64;
          modules = guiModules ++ [ ./hosts/laptop.nix ];
        };
        "ryleu@ripi" = mkHome {
          pkgs = arm64;
          modules = baseModules ++ [ ./hosts/raspi.nix ];
        };
        "ryleu@rectangle" = mkHome {
          pkgs = amd64;
          modules = guiModules ++ [ ./hosts/desktop.nix ./hosts/server.nix ];
        };
        "ryleu@redoak" = mkHome {
          pkgs = amd64;
          modules = baseModules ++ [ ./hosts/server.nix ];
        };
        "ryleu@ivy" = mkHome {
          pkgs = amd64;
          modules = baseModules ++ [ ./hosts/server.nix ];
        };
      };
    };
}
