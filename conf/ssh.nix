{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = ''
      PreferredAuthentications publickey,password
      IdentitiesOnly true
      IdentityFile ~/.ssh/id_ed25519
    '';
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        forwardAgent = true;
        compression = true;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };

      "ripi" = {
        hostname = "ripi";
        user = "ryleu";
        identityFile = "~/.ssh/ripi";
        identitiesOnly = true;
      };

      "voron" = {
        hostname = "192.168.193.62";
        user = "voron2";
        identityFile = "~/.ssh/voron";
        identitiesOnly = true;
      };

      "redoak" = {
        hostname = "redoak";
        user = "ryleu";
        identityFile = "~/.ssh/redoak";
        identitiesOnly = true;
      };

      "proxy" = {
        hostname = "proxy";
        user = "ryleu";
        identityFile = "~/.ssh/proxy";
        identitiesOnly = true;
      };

      "monument" = {
        hostname = "monument";
        user = "truenas_admin";
        identityFile = "~/.ssh/monument";
        identitiesOnly = true;
      };

      "monument.lan" = {
        hostname = "192.168.1.210";
        user = "truenas_admin";
        identityFile = "~/.ssh/monument";
        identitiesOnly = true;
      };

      "clucky" = {
        hostname = "192.168.1.69";
        user = "clucky";
        identityFile = "~/.ssh/clucky";
        identitiesOnly = true;
      };

      "spotipi" = {
        hostname = "spotipi";
        user = "ryleu";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };

      "rectangle" = {
        hostname = "rectangle";
        user = "ryleu";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };

      "remotebuild" = {
        hostname = "remotebuild.ryleu.me";
	user = "nixremote";
	identityFile = "~/.ssh/id_ed25519";
	identitiesOnly = true;
	port = 2222;
      };
    };
  };
}
