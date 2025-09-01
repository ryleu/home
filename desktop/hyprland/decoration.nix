{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 10;

      blur = {
        enabled = true;
        xray = false;
        special = false;
        ignore_opacity = true;
        new_optimizations = true;
        popups = true;
        input_methods = true;
        size = 8;
        passes = 2;
      };

      shadow = {
    	enabled = true;
        range = 20;
        render_power = 3;
        color = "rgba(131317d4)";
      };
    };
  };
}
