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
	services = {
	  useTwelveHourClock = false;
	};
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
