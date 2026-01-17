{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;

      bezier = [
        "specialWorkSwitch, 0.05, 0.5, 0.1, 1"
        "emphasizedAccel, 0.3, 0, 0.5, 0.15"
        "emphasizedDecel, 0.05, 0.5, 0.1, 1"
        "standard, 0.2, 0, 0, 1"
      ];

      animation = [
        "layersIn, 1, 1, emphasizedDecel, slide"
        "layersOut, 1, 1, emphasizedAccel, slide"
        "fadeLayers, 1, 1, standard"
        "windowsIn, 1, 1, emphasizedDecel"
        "windowsOut, 1, 1, emphasizedAccel"
        "windowsMove, 1, 1, standard"
        "workspaces, 1, 1, standard"
        "specialWorkspace, 1, 1, specialWorkSwitch, slidefadevert 15%"
        "fade, 1, 1, standard"
        "fadeDim, 1, 1, standard"
        "border, 1, 1, standard"
      ];
    };
  };
}
