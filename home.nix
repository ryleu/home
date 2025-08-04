{ pkgs, ... }:

{
  home = {
    username = "ryleu";
    homeDirectory = "/home/ryleu";
    stateVersion = "25.05"; # do not change without first properly migrating your setup!

    sessionVariables = {
      EDITOR = "vim";
      HYPHEN_INSENSITIVE = "true";
    };
  };

  programs = {
    thefuck = {
      enable = true;
      alias = "heck";
    };

    vim = {
      defaultEditor = true;
      extraConfig = builtins.readFile ./conf/config.vim;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user = {
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFeciFh+2gPJVraEZ33Gne4jDQdeYNlG3Q0czt0hVsrv";
          email = "69326171+ryleu@users.noreply.github.com";
          name = "ryleu";
        };
        core.editor = "vim";
        init.defaultBranch = "main";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        ignoreAllDups = true;
        share = true;
      };
      shellAliases = {
        la = "ls -alF";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
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

  nixpkgs.config = {
    allowUnfree = true;
  };
}
