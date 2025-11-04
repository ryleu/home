{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nil
      rust-analyzer
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    git.extraConfig.core.editor = "nvim";

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        # web
        coc-html

        # python
        coc-pyright

        # other
        coc-sh
        coc-json
        coc-docker
        coc-git
	render-markdown-nvim

        nvim-treesitter.withAllGrammars
      ];

      coc = {
        enable = true;
        settings = {
          languageserver = {
            rust = {
              command = "rust-analyzer";
              args = [ ];
              rootPatterns = [
                "*.rs"
              ];
              filetypes = [ "rust" ];
            };

            nix = {
              command = "nil";
              args = [ ];
              filetypes = [ "nix" ];
            };
          };
          coc.preferences.formatOnType = true;
        };
      };
    };
  };
}
