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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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
        inherit pkgs;
        modules = baseModules ++ guiModules;
      };
    in {
      homeConfigurations = {
        "ryleu@barely-better" = default;
        "ryleu@mathrock" = default;
        "ryleu@ripi" = {
          inherit pkgs;
          modules = baseModules ++ [
            ./hosts/ripi.nix
          ];
        };
        "ryleu@rectangle" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = baseModules ++ guiModules ++ [
            ./hosts/rectangle.nix
          ];
        };
      };
    };
}
