{
  config,
  pkgs,
  unstable_pkgs,
  ...
}:

{
  home = {
    username = "ryleu";
    homeDirectory = "/home/ryleu";
    stateVersion = "25.05"; # do not change without first properly migrating your setup!

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager.
    sessionVariables = {
      EDITOR = "vim";
      HYPHEN_INSENSITIVE = "true";
    };
  };

  programs = {
    thefuck.enable = true;

    helix = {
      enable = true;
      settings = {
        theme = "gruvbox";
      };
    };

    vim = {
      defaultEditor = true;
      extraConfig = builtins.readFile ./conf/vimrc.vim;
      plugins = with pkgs.vimPlugins; [
        vim-sleuth
      ];
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
    permittedInsecurePackages = [
      "electron-27.3.11"
    ];
  };
}
