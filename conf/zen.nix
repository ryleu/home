{
  inputs,
  pkgs,
  ...
}:

{
  nixpkgs = {
    overlays = [
      inputs.firefox-addons.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser =
    let
      mkLockedAttrs = builtins.mapAttrs (
        _: value: {
          Value = value;
          Status = "locked";
        }
      );
    in
    {
      enable = true;

      nativeMessagingHosts = [ pkgs.firefoxpwa ];

      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        DisableSetDesktopBackground = true;

        SearchEngines = {
          Add = [
            {
              "Name" = "Unduck";
              "URLTemplate" = "https://s.dunkirk.sh?q={searchTerms}";
              "Method" = "GET";
              "IconURL" = "https://s.dunkirk.sh/favicon.ico";
              "Alias" = "undk";
              "Description" = "ddg bangs pwa";
            }
          ];
          Default = "Unduck";
          PreventInstalls = true;
        };

        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
          "middlemouse.paste" = false;
          "browser.tabs.inTitlebar" = 0;
        };
        Permissions = {
          Autoplay = {
            Default = "block-audio-video";
          };
        };
      };

      profiles.default = {
        mods = [
          "1b88a6d1-d931-45e8-b6c3-bfdca2c7e9d6" # Remove Tab X
          "c01d3e22-1cee-45c1-a25e-53c0f180eea8" # Ghost Tabs
          "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
        ];

        extensions.packages = with pkgs.firefox-addons; [
          bitwarden
          tasks-for-canvas
          ublock-origin
	  sponsorblock
	  youtube-recommended-videos
        ];
      };
    };
}
