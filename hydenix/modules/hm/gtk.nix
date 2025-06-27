{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.gtk;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.gtk = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable gtk module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gtk3
      gtk4
      glib
      gsettings-desktop-schemas
      gnome-settings-daemon
      gnome-tweaks
      gnomeExtensions.window-gestures
      nwg-look
      adwaita-icon-theme
      emote
    ];
    home.file = {
      ".config/nwg-look/config" = lib.file.mkOutOfStoreSymlink "${dot}/gtk/nwg-look/config";

      # stateful files
      ".config/gtk-3.0/settings.ini" = {
        source = lib.file.mkOutOfStoreSymlink "${dot}/gtk/gtk-3.0/settings.ini";
        force = true;
        mutable = true;
      };
      ".gtkrc-2.0" = {
        source = lib.file.mkOutOfStoreSymlink "${dot}/gtk/gtkrc-2.0";
        force = true;
        mutable = true;
      };

      ".config/xsettingsd/xsettingsd.conf" = {
        source = lib.file.mkOutOfStoreSymlink "${dot}/gtk/xsettingsd/xsettingsd.conf";
        force = true;
        mutable = true;
      };

    };
  };
}
