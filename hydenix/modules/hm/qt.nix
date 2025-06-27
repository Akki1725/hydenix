{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.qt;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.qt = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable qt module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qt5.qtbase
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qtimageformats
      libsForQt5.qtsvg
      libsForQt5.qt5.qtwayland
      kdePackages.qt6ct
      kdePackages.qtbase
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kdePackages.breeze-icons
      kdePackages.qtimageformats
      kdePackages.qtsvg
      kdePackages.qtwayland
    ];

    home.file = {
      ".config/qt5ct/qt5ct.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/qt5ct/qt5ct.conf";
      };
      ".config/qt6ct/qt6ct.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/qt6ct/qt6ct.conf";
      };
      ".config/menus/applications.menu" = {
        source = lib.mkOutOfStoreSymlink "${dot}/menus/applications.menu";
      };

      ".config/Kvantum/wallbash/wallbash.kvconfig" = {
        source = lib.mkOutOfStoreSymlink "${dot}/Kvantum/wallbash/wallbash.kvconfig";
        force = true;
        mutable = true;
      };
      ".config/Kvantum/wallbash/wallbash.svg" = {
        source = lib.mkOutOfStoreSymlink "${dot}/Kvantum/wallbash/wallbash.svg";
        force = true;
        mutable = true;
      };
      ".config/Kvantum/kvantum.kvconfig" = {
        source = lib.mkOutOfStoreSymlink "${dot}/Kvantum/kvantum.kvconfig";
        force = true;
        mutable = true;
      };
      # stateful files
      ".config/kdeglobals" = {
        source = lib.mkOutOfStoreSymlink "${dot}/kdeglobals";
        force = true;
        mutable = true;
      };
      ".config/qt5ct/colors.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/qt5ct/colors.conf";
        force = true;
        mutable = true;
      };
      ".config/qt6ct/colors.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/qt6ct/colors.conf";
        force = true;
        mutable = true;
      };
    };
  };
}
