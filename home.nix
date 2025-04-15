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
      vim
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
      python3

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
      bashrcExtra = ''
        export EDITOR="vim"
      '';
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
