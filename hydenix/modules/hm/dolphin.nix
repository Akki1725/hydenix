{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.dolphin;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.dolphin = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable dolphin module";
    };
  };

  config = lib.mkIf cfg.enable {

    #! we are using libsForQt5 because dolphin likes to break things like icons on qt6
    home.packages = with pkgs.kdePackages; [
      dolphin # KDE file manager
      qtimageformats # Image format support for Qt5
      ffmpegthumbs # Video thumbnail support
      kde-cli-tools # KDE command line utilities
      kdegraphics-thumbnailers # KDE graphics thumbnails
      kimageformats # Additional image format support for KDE
      qtsvg # SVG support
      kio # KDE I/O framework
      kio-extras # Additional KDE I/O protocols
      kwayland # KDE Wayland integration
    ];

    xdg.mimeApps = {
      defaultApplications = {
        "inode/directory" = [ "org.kde.dolphin.desktop" ];
        "x-scheme-handler/file" = [ "org.kde.dolphin.desktop" ];
        "x-scheme-handler/about" = [ "org.kde.dolphin.desktop" ];
      };
    };

    home.file = {
      ".config/dolphinrc".source = lib.file.mkOutOfStoreSymlink "${dot}/dolphin/dolphinrc";

      ".config/baloofilerc".source = lib.file.mkOutOfStoreSymlink "${dot}/dolphin/baloofilerc";

      ".config/menus/applications.menu".source = lib.file.mkOutOfStoreSymlink "${dot}/dolphin/menus/applications.menu";


      # stateful file for themes
      ".config/kdeglobals" = {
        source = lib.file.mkOutOfStoreSymlink "${dot}/dolphin/kdeglobals";
        force = true;
        mutable = true;
      };

    };
  };
}
