{
  description = "Home Manager configuration of ryleu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      zen-browser,
      home-manager,
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
            zen_browser = zen-browser;
          };
          inherit modules;
        };

      baseModules = [
        ./home.nix
        ./conf/ssh.nix
	./conf/nvim.nix
        ./packages/cli.nix
      ];
      guiModules = baseModules ++ [
        ./conf/hyprland.nix
        ./conf/waybar.nix
        ./conf/sway.nix
        ./conf/zen.nix
        ./packages/apps.nix
        ./packages/desktop.nix
        ./packages/fonts.nix
        ./packages/work.nix
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
