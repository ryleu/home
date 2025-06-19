{
  description = "Home Manager configuration of ryleu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs_unstable,
      home-manager,
      ...
    }:
    let
      # Helper to generate package sets for a given system.
      pkgsFor = system: {
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = nixpkgs_unstable.legacyPackages.${system};
      };

      amd64 = pkgsFor "x86_64-linux";
      arm64 = pkgsFor "aarch64-linux";

      # Helper to generate a home-manager configuration.
      mkHome =
        {
          pkgs,
          unstable,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            unstable_pkgs = unstable;
          };
          inherit modules;
        };

      baseModules = [
        ./home.nix
        ./conf/ssh.nix
        ./packages/cli.nix
      ];
      guiModules = [
        ./conf/hyprland.nix
        ./conf/sway.nix
        ./packages/apps.nix
        ./packages/desktop.nix
        ./packages/fonts.nix
      ];
    in
    {
      homeConfigurations = {
        "ryleu@barely-better" = mkHome {
          pkgs = amd64.pkgs;
          unstable = amd64.unstable;
          modules =
            baseModules
            ++ guiModules
            ++ [
              ./hosts/barely-better.nix
            ];
        };
        "ryleu@mathrock" = mkHome {
          pkgs = amd64.pkgs;
          unstable = amd64.unstable;
          modules = baseModules ++ guiModules;
        };
        "ryleu@ripi" = mkHome {
          pkgs = arm64.pkgs;
          unstable = arm64.unstable;
          modules = baseModules ++ [ ./hosts/ripi.nix ];
        };
        "ryleu@rectangle" = mkHome {
          pkgs = amd64.pkgs;
          unstable = amd64.unstable;
          modules =
            baseModules
            ++ guiModules
            ++ [
              ./hosts/rectangle.nix
            ];
        };
        "ryleu@redoak" = mkHome {
          pkgs = amd64.pkgs;
          unstable = amd64.unstable;
          modules = baseModules ++ [ ./hosts/redoak.nix ];
        };
        "ryleu@ivy" = mkHome {
          pkgs = amd64.pkgs;
          unstable = amd64.unstable;
          modules = baseModules ++ [ ./hosts/redoak.nix ];
        };
      };
    };
}
