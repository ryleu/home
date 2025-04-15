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
      baseModules = [ ./home.nix ./conf/hyprland.nix ];
      default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = baseModules;
      };
    in {
      homeConfigurations = {
        "ryleu@barely-better" = default;
        "ryleu@mathrock" = default;
        "ryleu@rectangle" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = baseModules ++ [
            ./hosts/rectangle.nix
          ];
        };
      };
    };
}
