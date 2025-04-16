{ config, pkgs, ... }:

let
  monoFont = "FiraCode Nerd Font";
  fontFeatures = [
    "liga"
    "calt"
    "cv01"
    "cv02"
    "cv04"
    "ss01"
    "ss06"
  ];
in
{
  home = {
    username = "ryleu";
    homeDirectory = "/home/ryleu";
    stateVersion = "24.11"; # do not change without first properly migrating your setup!

    packages = with pkgs; [
      # desktop
      gnomeExtensions.appindicator
      hyprcursor
      waybar
      grimblast
      wofi
      phinger-cursors
      papirus-icon-theme
      networkmanagerapplet

      # fonts
      fira-code-nerdfont
      minecraftia
      unifont

      # development
      gh
      nix-index
      nixd
      nil
      wget
      cargo
      rustc
      rustfmt
      nix-search
      nixfmt-rfc-style
      ffmpeg-full
      python314
      wl-clipboard

      # apps
      vlc
      spotify
      prismlauncher
      brave
      zed-editor
      vesktop
      vscode
      rstudio
      zotero
      logseq
      jetbrains.idea-community-src
      gabutdm
      htop
      fastfetch
      nvtopPackages.full
      prusa-slicer
      bambu-studio
    ];

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
    };

    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ monoFont ];
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "phinger-cursors-light";
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
  };

  programs = {
    thefuck.enable = true;
    firefox.enable = true;

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
        let &t_ut=\'\'
      '';
    };

    zed-editor =
      let
        zedFontFeatures = builtins.listToAttrs (
          map (feature: {
            name = feature;
            value = true;
          }) fontFeatures
        );
      in
      {
        enable = true;
        extensions = [
          "git-firefly"
          "nix"
          "cargo-tom"
        ];
        userSettings = {
          assistant = {
            default_model = {
              provider = "copilot_chat";
              model = "claude-3-5-sonnet";
            };
            version = "2";
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          hour_format = "hour24";
          auto_update = false;
          vim_mode = true;
          ui_font_size = 16;
          theme = {
            mode = "system";
            light = "One Light";
            dark = "One Dark";
          };
          languages = {
            "Nix" = {
              language_servers = [
                "nixd"
                "nil"
              ];
            };
          };
          buffer_font_size = 16;
          buffer_font_family = monoFont;
          buffer_font_features = zedFontFeatures;
          terminal = {
            font_family = monoFont;
            font_features = zedFontFeatures;
            env = {
              "TERM" = "xterm-256color";
            };
          };
        };
      };

    kitty = {
      enable = true;
      font = {
        name = monoFont;
        size = 13;
      };
      settings = {
        disable_ligatures = "cursor";
        font_family =
          "family=\"${monoFont}\" features=\"" + (builtins.concatStringsSep " +" fontFeatures) + "\"";
        notify_on_cmd_finish = "invisible";
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user = {
          signingkey = "~/.ssh/github.pub";
          email = "69326171+ryleu@users.noreply.github.com";
          name = "ryleu";
        };
        core.editor = "vim";
        init.defaultBranch = "main";
      };
    };

    bash = {
      enable = true;
    };

    starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };

    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
  };

  services = {
    mako = {
      enable = true;
      actions = true;
      anchor = "top-right";
      backgroundColor = "#000000ff";
      borderColor = "#00ff99ee";
      textColor = "#ffffffff";
      borderRadius = 10;
      borderSize = 2;
      defaultTimeout = 3000;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;

    permittedInsecurePackages = [
      # temporary to allow installation of logseq
      "electron-27.3.11"
    ];
  };

}
