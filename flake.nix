{
  description = "Home Manager configuration of ryleu";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      amd64_pkgs = nixpkgs.legacyPackages."x86_64-linux";
      arm64_pkgs = nixpkgs.legacyPackages."aarch64-linux";

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
      default = home-manager.lib.homeManagerConfiguration {
        pkgs = amd64_pkgs;
        modules = baseModules ++ guiModules;
      };
    in {
      homeConfigurations = {
        "ryleu@barely-better" = home-manager.lib.homeManagerConfiguration {
          pkgs = amd64_pkgs;
          modules = baseModules ++ guiModules ++ [
            ./hosts/barely-better.nix
          ];
        };
        "ryleu@mathrock" = default;
        "ryleu@ripi" = home-manager.lib.homeManagerConfiguration {
          pkgs = arm64_pkgs;
          modules = baseModules ++ [
            ./hosts/ripi.nix
          ];
        };
        "ryleu@rectangle" = home-manager.lib.homeManagerConfiguration {
          pkgs = amd64_pkgs;
          modules = baseModules ++ guiModules ++ [
            ./hosts/rectangle.nix
          ];
        };
      };
    };
}

