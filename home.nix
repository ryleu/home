{ config, pkgs, ... }:

{
  home = {
    username = "ryleu";
    homeDirectory = "/home/ryleu";
    stateVersion = "24.11";

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
      extraConfig = ''
        " Mouse support
        set mouse=a
        set ttymouse=sgr
        set balloonevalterm
        " Styled and colored underline support
        let &t_AU = "\e[58:5:%dm"
        let &t_8u = "\e[58:2:%lu:%lu:%lum"
        let &t_Us = "\e[4:2m"
        let &t_Cs = "\e[4:3m"
        let &t_ds = "\e[4:4m"
        let &t_Ds = "\e[4:5m"
        let &t_Ce = "\e[4:0m"
        " Strikethrough
        let &t_Ts = "\e[9m"
        let &t_Te = "\e[29m"
        " Truecolor support
        let &t_8f = "\e[38:2:%lu:%lu:%lum"
        let &t_8b = "\e[48:2:%lu:%lu:%lum"
        let &t_RF = "\e]10;?\e\\"
        let &t_RB = "\e]11;?\e\\"
        " Bracketed paste
        let &t_BE = "\e[?2004h"
        let &t_BD = "\e[?2004l"
        let &t_PS = "\e[200~"
        let &t_PE = "\e[201~"
        " Cursor control
        let &t_RC = "\e[?12$p"
        let &t_SH = "\e[%d q"
        let &t_RS = "\eP$q q\e\\"
        let &t_SI = "\e[5 q"
        let &t_SR = "\e[3 q"
        let &t_EI = "\e[1 q"
        let &t_VS = "\e[?12l"
        " Focus tracking
        let &t_fe = "\e[?1004h"
        let &t_fd = "\e[?1004l"
        execute "set <FocusGained>=\<Esc>[I"
        execute "set <FocusLost>=\<Esc>[O"
        " Window title
        let &t_ST = "\e[22;2t"
        let &t_RT = "\e[23;2t"
        
        " vim hardcodes background color erase even if the terminfo file does
        " not contain bce. This causes incorrect background rendering when
        " using a color theme with a background color in terminals such as
        " kitty that do not support background color erase.
        let &t_ut=''''
      '';
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
      shellAliases = {
        la = "ls -alF";
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

    home-manager.enable = true;

    starship = {
      enable = true;
      settings = {
        # Disable the blank line at the start of the prompt
        add_newline = false;

        # Configure the prompt format to match robbyrussell theme
        format = "$all";

        # Configure individual prompt segments
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };

        directory = {
          style = "blue bold";
          truncation_length = 3;
          truncation_symbol = "…/";
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          style = "bold yellow";
        };

        git_status = {
          format = "[$all_status$ahead_behind]($style) ";
          style = "bold red";
          conflicted = "💥";
          ahead = "🏎💨";
          behind = "😰";
          diverged = "🔀";
          untracked = "?";
          stashed = "$";
          modified = "!";
          staged = "+";
          renamed = "»";
          deleted = "✘";
        };
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-27.3.11"
    ];
  };
}