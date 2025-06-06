{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    compression = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github";
      };

      "ripi" = {
        hostname = "ripi";
        user = "ryleu";
        identityFile = "~/.ssh/ripi";
      };

      "voron" = {
        hostname = "192.168.193.62";
        user = "voron2";
        identityFile = "~/.ssh/voron";
      };

      "redoak" = {
        hostname = "redoak";
        user = "ryleu";
        identityFile = "~/.ssh/redoak";
      };

      "monument" = {
        hostname = "monument";
        user = "truenas_admin";
        identityFile = "~/.ssh/monument";
      };

      "clucky" = {
        hostname = "192.168.1.69";
        user = "clucky";
        identityFile = "~/.ssh/clucky";
      };
    };
  };
}
