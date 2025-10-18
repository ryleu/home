{
  caelestia,
  font,
  ...
}:
{
  imports = [
    caelestia.homeManagerModules.default
  ];

  programs = {
    caelestia = {
      enable = true;
      systemd.enable = true;
      settings = {
        appearance = {
          anim.durations.scale = 1.5;

	  font = {
            family = {
	      clock = "Rubik";
	      material = "Material Symbols Rounded";
	      mono = font.mono.family;
	      sans = "Rubik";
	    };

	    size.scale = 1;
	  };
	};

	general = {
	  apps = {
	    terminal = ["kitty"];
	    playback = ["vlc"];
	    explorer = ["nautilus"];
	  };

          idle = {
            lockBeforeSleep = true;
	    inhibitWhenAudio = true;
	    timeouts = [
              {
	        timeout = 300;
		idleAction = "lock";
	      }
	      {
	        timeout = 360;
		idleAction = "dpms off";
		returnAction = "dpms on";
	      }
	      {
	        timeout = 600;
		idleAction = ["systemctl" "suspend-then-hibernate"];
	      }
	    ];
	  };
	};

        background.enabled = true;

	launcher.useFuzzy.apps = true;

        paths.wallpaperDir = "~/Pictures/Wallpapers";

        services = {
          useTwelveHourClock = false;
        };

	utilities.vpn = {
          enabled = true;
	  provider = [
	    {
	      name = "wireguard";
	      interface = "wg0";
	      displayName = "Home";
	    }
	  ];
	};
      };
      cli = {
        enable = true;
        settings = {
          theme.enableGtk = true;
        };
      };
    };
  };
}
