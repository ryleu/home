{
  zen_browser,
  font,
  pkgs,
  ...
}:

{
  imports = [
    zen_browser.homeModules.twilight
  ];

  programs = {
    zen-browser = {
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

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            # ublock
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            # bitwarden
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "admin@2fas.com" = {
            # 2fas
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/2fas-two-factor-authentication/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        Preferences = {
          "browser.tabs.warnOnClose" = {
            "Value" = false;
            "Status" = "locked";
          };
        };
        Permissions = {
          Autoplay = {
            Default = "block-audio-video";
          };
        };
      };
    };
  };
}
