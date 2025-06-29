{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.notifications;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.notifications = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable notifications module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dunst # notification daemon
    ];

    home.file = {
      # # stateful file for themes
      ".config/dunst/dunstrc" = {
        source = lib.mkOutOfStoreSymlink "${dot}/dunst/dunstrc";
        force = true;
        mutable = true;
      };
      ".config/dunst/dunst.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/dunst/dunst.conf";
        force = true;
        mutable = true;
      };
    };
  };
}
