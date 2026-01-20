{
  description = "Home Manager configuration of ryleu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      zen-browser,
      home-manager,
      caelestia-shell,
      ...
    }:
    let
      # Helper to generate package sets for a given system.
      pkgsFor =
        system:
        let
          config.allowUnfree = true;
        in
        {
          pkgs = (
            import nixpkgs {
              inherit system;
              inherit config;
            }
          );

          unstable = (
            import nixpkgs-unstable {
              inherit system;
              inherit config;
            }
          );

          caelestia = caelestia-shell;
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
              emoji = {
                family = "Noto Color Emoji";
                features = [ ];
              };
              fallback = "Unifont";
            };
            cursor = {
              name = "phinger-cursors-light";
              package = pkgs.pkgs.phinger-cursors;
              size = 24;
            };

            unstable_pkgs = pkgs.unstable;
            caelestia = pkgs.caelestia;
            zen_browser = zen-browser;
          };
          inherit modules;
        };

      baseModules = [
        ./home.nix
        ./conf/ssh.nix
        ./conf/nvim.nix
        ./conf
        ./packages/cli.nix
      ];
      guiModules = baseModules ++ [
        ./desktop
        ./conf/zen.nix
        ./packages
      ];
    in
    {
      homeConfigurations = {
        "ryleu@barely-better" = mkHome {
          pkgs = amd64;
          modules = guiModules ++ [
            ./hosts/barely-better.nix
          ];
        };
        "ryleu@mathrock" = mkHome {
          pkgs = amd64;
          modules = guiModules ++ [ ];
        };
        "ryleu@ripi" = mkHome {
          pkgs = arm64;
          modules = baseModules ++ [ ./hosts/raspi.nix ];
        };
        "ryleu@rectangle" = mkHome {
          pkgs = amd64;
          modules = guiModules ++ [
            ./hosts/rectangle.nix
            ./hosts/server.nix
          ];
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
