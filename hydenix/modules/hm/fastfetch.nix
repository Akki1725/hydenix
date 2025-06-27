{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.fastfetch;
  dot = config.hydenix.hm.dotfilesPath;
in
{
  options.hydenix.hm.fastfetch = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable fastfetch configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/fastfetch/config.jsonc".source =
        lib.file.mkOutOfStoreSymlink "${dot}/fastfetch/config.jsonc";
    
      ".config/fastfetch/logos" = {
        source = lib.file.mkOutOfStoreSymlink "${dot}/fastfetch/logos";
        recursive = true;
      };
    };

  };
}
