{ caelestia, ... }:
{
  imports = [
    caelestia.homeManagerModules.default
  ];

  programs = {
    caelestia = {
      enable = true;
      systemd.enable = true;
      settings = {
        paths.wallpaperDir = "~/Pictures/Wallpapers";
      };
      cli = {
        enable = true;
        settings = {
          theme.enableGtk = true;

	  background = {
	    enabled = true;

	    visualiser = {
	      enabled = true;
	      autoHide = true;
	    };
          };
        };
      };
    };
  };
}
