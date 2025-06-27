{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.editors;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.editors = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable text editors module";
    };

    vscode = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable vscode";
      };

      wallbash = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable wallbash extension for vscode";
      };
    };

    neovim = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable neovim";
    };

    vim = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable vim";
    };

    default = lib.mkOption {
      type = lib.types.str;
      default = "code";
      description = "Default text editor";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.vim vim) # terminal text editor
      (lib.mkIf cfg.neovim neovim) # terminal text editor
    ];

    programs.vscode = lib.mkIf cfg.vscode.enable {
      enable = true;
      package = pkgs.vscode.fhs;
      mutableExtensionsDir = true;
    };

    home.file = lib.mkMerge [
      (lib.mkIf cfg.vscode.enable {
        # Editor flags
        ".config/code-flags.conf".source = lib.file.mkOutOfStoreSymlink "${dot}/editors/code-flags.conf";
        ".config/codium-flags.conf".source = lib.file.mkOutOfStoreSymlink "${dot}/editors/codium-flags.conf";


        # VS Code settings
        ".config/Code - OSS/User/settings.json" = {
          source = lib.file.mkOutOfStoreSymlink "${dot}/editors/vscode-settings.json";
          force = true;
          mutable = true;
        };
        ".config/Code/User/settings.json" = {
          source = config.home.file.".config/Code/User/settings.json";
          force = true;
          mutable = true;
        };
        ".config/VSCodium/User/settings.json" = {
          source = config.home.file.".config/Code/User/settings.json";
          force = true;
          mutable = true;
        };
      })

      (lib.mkIf cfg.vscode.wallbash {
        # Link the wallbash extension from hyde package
        ".vscode/extensions/prasanthrangan.wallbash" = {
          source = lib.file.mkOutOfStoreSymlink "${dot}/editors/prasanthrangan.wallbash";
          recursive = true;
          mutable = true;
          force = true;
        };
      })

      (lib.mkIf (cfg.vim or cfg.neovim) {
        ".config/vim/colors/wallbash.vim" = {
          source = lib.file.mkOutOfStoreSymlink "${dot}/editors/vim/colors/wallbash.vim";
          force = true;
          mutable = true;
        };
        ".config/vim/hyde.vim".source = lib.file.mkOutOfStoreSymlink "${dot}/editors/vim/hyde.vim";
        ".config/vim/vimrc".source = lib.file.mkOutOfStoreSymlink "${dot}/editors/vim/vimrc";

      })
    ];

    home.sessionVariables = {
      EDITOR = cfg.default;
      VISUAL = cfg.default;
    };
  };
}
