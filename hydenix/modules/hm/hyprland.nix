{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;
  dot = config.hydenix.hm.dotfilesPath;
in
{

  options.hydenix.hm.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable hyprland module";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra config for hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprcursor
      hyprutils
      xdg-desktop-portal-hyprland
      hyprpicker
      hypridle
    ];

    home.activation.createHyprConfigs = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
      mkdir -p "$HOME/.config/hypr/animations"
      mkdir -p "$HOME/.config/hypr/themes"

      touch "$HOME/.config/hypr/animations/theme.conf"
      touch "$HOME/.config/hypr/themes/colors.conf"
      touch "$HOME/.config/hypr/themes/theme.conf"
      touch "$HOME/.config/hypr/themes/wallbash.conf"

      chmod 644 "$HOME/.config/hypr/animations/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/colors.conf"
      chmod 644 "$HOME/.config/hypr/themes/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/wallbash.conf"
    '';

    home.file = {
      ".config/hypr/hyprland.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/hypr/hyprland.conf";
        force = true;
      };
      ".config/hypr/hyde.conf".source = lib.mkOutOfStoreSymlink "${dot}/hypr/hyde.conf";
      ".config/hypr/keybindings.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/keybindings.conf";
      ".config/hypr/monitors.conf".source = lib.mkOutOfStoreSymlink "${dot}/hypr/monitors.conf";
      ".config/hypr/nvidia.conf".source = lib.mkOutOfStoreSymlink "${dot}/hypr/nvidia.conf";
      ".config/hypr/userprefs.conf" = {
        text = ''
          ${cfg.extraConfig}
        '';
        force = true;
      };
      ".config/hypr/windowrules.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/windowrules.conf";
      ".config/hypr/animations.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/hypr/animations.conf";
        force = true;
        mutable = true;
      };
      ".config/hypr/animations/classic.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/classic.conf";
      ".config/hypr/animations/diablo-1.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/diablo-1.conf";
      ".config/hypr/animations/diablo-2.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/diablo-2.conf";
      ".config/hypr/animations/dynamic.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/dynamic.conf";
      ".config/hypr/animations/disable.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/disable.conf";
      ".config/hypr/animations/eevee-1.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/eevee-1.conf";
      ".config/hypr/animations/eevee-2.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/eevee-2.conf";
      ".config/hypr/animations/high.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/high.conf";
      ".config/hypr/animations/low-1.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/low-1.conf";
      ".config/hypr/animations/low-2.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/low-2.conf";
      ".config/hypr/animations/minimal-1.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/minimal-1.conf";
      ".config/hypr/animations/minimal-2.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/minimal-2.conf";
      ".config/hypr/animations/moving.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/moving.conf";
      ".config/hypr/animations/optimized.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/optimized.conf";
      ".config/hypr/animations/standard.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/standard.conf";
      ".config/hypr/animations/vertical.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/vertical.conf";
      ".config/hypr/animations/LimeFrenzy.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/animations/LimeFrenzy.conf";
      ".config/hypr/hypridle.conf".source = lib.mkOutOfStoreSymlink "${dot}/hypr/hypridle.conf";

      # Shaders
      ".config/hypr/shaders/blue-light-filter.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/blue-light-filter.frag";
      ".config/hypr/shaders/color-vision.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/color-vision.frag";
      ".config/hypr/shaders/.compiled.cache.glsl" = {
        source = lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/.compiled.cache.glsl";
        force = true;
        mutable = true;
      };
      ".config/hypr/shaders.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/hypr/shaders.conf";
        force = true;
        mutable = true;
      };
      ".config/hypr/shaders/custom.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/custom.frag";
      ".config/hypr/shaders/disable.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/disable.frag";
      ".config/hypr/shaders/grayscale.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/grayscale.frag";
      ".config/hypr/shaders/invert-colors.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/invert-colors.frag";
      ".config/hypr/shaders/oled.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/oled.frag";
      ".config/hypr/shaders/oled-saver.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/oled-saver.frag";
      ".config/hypr/shaders/paper.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/paper.frag";
      ".config/hypr/shaders/vibrance.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/vibrance.frag";
      ".config/hypr/shaders/wallbash.frag".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/wallbash.frag";
      ".config/hypr/shaders/wallbash.inc".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/shaders/wallbash.inc";

      # Workflows
      ".config/hypr/workflows.conf" = {
        source = lib.mkOutOfStoreSymlink "${dot}/hypr/workflows.conf";
        force = true;
        mutable = true;
      };
      ".config/hypr/workflows/default.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/workflows/default.conf";
      ".config/hypr/workflows/editing.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/workflows/editing.conf";
      ".config/hypr/workflows/gaming.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/workflows/gaming.conf";
      ".config/hypr/workflows/powersaver.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/workflows/powersaver.conf";
      ".config/hypr/workflows/snappy.conf".source =
        lib.mkOutOfStoreSymlink "${dot}/hypr/workflows/snappy.conf";
    };
  };
}
