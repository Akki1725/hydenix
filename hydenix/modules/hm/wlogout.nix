{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.wlogout;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.wlogout = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable logout module";
    };

    wlogout = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable wlogout";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [

      # wlogout
      (lib.mkIf cfg.wlogout.enable wlogout) # logout menu
    ];

    home.file = {

      # icons
      ".config/wlogout/icons/" = {
        source = lib.mkOutOfStoreSymlink "${dot}/wlogout/icons/";
        recursive = true;
      };

      # Stateful files with themes
      ".config/wlogout/layout_1" = {
        source = lib.mkOutOfStoreSymlink "${dot}/wlogout/layout_1";
        force = true;
        mutable = true;
      };
      ".config/wlogout/style_1.css" = {
        source = lib.mkOutOfStoreSymlink "${dot}/wlogout/style_1.css";
        force = true;
        mutable = true;
      };
      ".config/wlogout/layout_2" = {
        source = lib.mkOutOfStoreSymlink "${dot}/wlogout/layout_2";
        force = true;
        mutable = true;
      };
      ".config/wlogout/style_2.css" = {
        source = lib.mkOutOfStoreSymlink "${dot}/wlogout/style_2.css";
        force = true;
        mutable = true;
      };

    };
  };
}
