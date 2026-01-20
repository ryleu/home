{ pkgs, lib, ... }:

{
  imports = [
    ./zsh
  ];

  home = {
    username = "ryleu";
    homeDirectory = "/home/ryleu";
    stateVersion = "25.05"; # do not change without first properly migrating your setup!

    sessionVariables = {
      HYPHEN_INSENSITIVE = "true";
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    };
  };

  programs = {
    pay-respects.enable = true;

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    vim = {
      extraConfig = builtins.readFile ./conf/config.vim;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      settings = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user = {
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFeciFh+2gPJVraEZ33Gne4jDQdeYNlG3Q0czt0hVsrv";
          email = "69326171+ryleu@users.noreply.github.com";
          name = "ryleu";
        };
        init.defaultBranch = "main";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      colors = "auto";
      icons = "auto";
    };

    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
  };

  services = {
    gnome-keyring = {
      enable = true;
      components = [ "secrets" ];
    };

    ssh-agent.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
}
