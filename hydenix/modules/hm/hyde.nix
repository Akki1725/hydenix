{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyde;
  dot = config.hydenix.hm.dotfilesPath;
in
{

  options.hydenix.hm.hyde = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable hyde module";
    };
  };

  # TODO: review stateful files in hyde module
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hydenix.hyde
      Bibata-Modern-Ice
      Tela-circle-dracula
      kdePackages.kconfig # TODO: not sure if this is still needed
      wf-recorder # screen recorder for wlroots-based compositors such as sway
    ];

    fonts.fontconfig.enable = true;

    # fixes cava from not initializing on boot
    home.activation.createCavaConfig = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
      mkdir -p "$HOME/.config/cava"
      touch "$HOME/.config/cava/config"
      chmod 644 "$HOME/.config/cava/config"
    '';

    home.file = {
      # Regular files (processed first)
      ".config/hyde/wallbash" = {
        source = lib.mkOutOfStoreSymlink "${dot}/hyde/wallbash";
        recursive = true;
        force = true;
        mutable = true;
      };

      ".config/systemd/user/hyde-config.service" = {
        source = lib.mkOutOfStoreSymlink "${dot}/systemd/user/hyde-config.service";
      };
      ".config/systemd/user/hyde-ipc.service" = {
        source = lib.mkOutOfStoreSymlink "${dot}/systemd/user/hyde-ipc.service";
      };

      ".local/bin/hyde-shell" = {
        source = "${pkgs.hydenix.hyde}/Configs/.local/bin/hyde-shell";
        executable = true;
      };

      ".local/bin/hydectl" = {
        source = "${pkgs.hydenix.hyde}/Configs/.local/bin/hydectl";
        executable = true;
      };

      ".local/bin/hyde-ipc" = {
        source = "${pkgs.hydenix.hyde}/Configs/.local/bin/hyde-ipc";
        executable = true;
      };

      ".local/lib/hyde" = {
        source = "${pkgs.hydenix.hyde}/Configs/.local/lib/hyde";
        recursive = true;
        force = true;
        mutable = true;
        executable = true;
      };

      ".local/lib/hyde/globalcontrol.sh" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/lib/hyde/globalcontrol.sh";
        executable = true;
      };

      ".local/share/fastfetch/presets/hyde" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/fastfetch/presets/hyde";
        recursive = true;
      };
      ".local/share/hyde" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/hyde";
        recursive = true;
        executable = true;
        force = true;
        mutable = true;
      };
      ".local/share/waybar/includes" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/waybar/includes";
        recursive = true;
      };
      ".local/share/waybar/layouts" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/waybar/layouts";
        recursive = true;
      };
      ".local/share/waybar/menus" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/waybar/menus";
        recursive = true;
      };
      ".local/share/waybar/modules" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/waybar/modules";
        recursive = true;
      };
      ".local/share/waybar/styles" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.local/share/waybar/styles";
        force = true;
        mutable = true;
        recursive = true;
      };
      ".config/MangoHud/MangoHud.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.internals/MangoHud/MangoHud.conf";
      };
      ".local/share/kio/servicemenus/hydewallpaper.desktop" = {
        source = lib.mkOutOfStoreSymlink "${dot}/share/kio/servicemenus/hydewallpaper.desktop";
      };
      ".local/share/kxmlgui5/dolphin/dolphinui.rc" = {
        source = lib.mkOutOfStoreSymlink "${dot}/share/kxmlgui5/dolphin/dolphinui.rc";
      };

      ".config/electron-flags.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.internals/electron-flags.conf";
      };

      ".local/share/icons/Wallbash-Icon" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.internals/icons/Wallbash-Icon";
        force = true;
        recursive = true;
        mutable = true;
      };

      # stateful files
      ".config/hyde/config.toml" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hyde/config.toml";
        force = true;
        mutable = true;
      };
      ".local/share/dolphin/view_properties/global/.directory" = {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/dolphin/view_properties/global/.directory";
        force = true;
        mutable = true;
      };
      ".local/share/icons/default/index.theme" = {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/icons/default/index.theme";
        force = true;
        mutable = true;
      };
      ".local/share/themes/Wallbash-Gtk" = {
        source = lib.mkOutOfStoreSymlink "${dot}/.internals/themes/Wallbash-Gtk";
        recursive = true;
        force = true;
        mutable = true;
      };
    };
  };
}
