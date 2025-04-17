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
        ./conf/hyprland.nix
        ./conf/ssh.nix
        ./packages/cli.nix
      ];
      guiModules = [
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
        "ryleu@barely-better" = default;
        "ryleu@mathrock" = default;
        "ryleu@ripi" = {
          pkgs = arm64_pkgs;
          system = "aarch64-linux";
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
