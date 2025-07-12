{ zen_browser, font, ... }:

{
  imports = [
    zen_browser.homeModules.twilight
  ];

  programs = {
    zen-browser = {
      enable = true;

      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabked = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
  
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = { # ublock
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { # bitwarden
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "admin@2fas.com" = { # 2fas
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
      };
    };
  };
}
