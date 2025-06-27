{ config, lib, pkgs, ... }:

let
  cfg = config.hydenix.hm.brave;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.brave = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;  # enable with global switch
      description = "Enable Brave browser module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      brave
    ];

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1"; # Just in case Brave respects it via Chromium flags
    };
  };
}
