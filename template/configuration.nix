{ config, inputs, pkgs, ... }:

let
  # Load custom nixpkgs with overlays and user-defined unfree packages
  customPkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
        };
      })
    ];
  };
in
{
  # Use our custom pkgs set globally
  nixpkgs.pkgs = customPkgs;

  imports = [
    ./hardware-configuration.nix

    # Home Manager
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager

    # System modules
    inputs.hydenix.lib.nixOsModules
    ./modules/system

    # Hardware configs (CPU/GPU/etc)
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd

    # === Optional Future GPU/CPU Tweaks ===
    # Uncomment the appropriate line if you switch hardware:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd
  ];

  # Systemd Boot Settings
      boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.timeout = 0;                  # Instant boot
      loader.systemd-boot.editor = false; # Disable manual boot entry editing
      consoleLogLevel = 0;                # Suppress boot messages
      initrd.verbose = false;
      kernelParams = [ "quiet" ];         # Hide kernel messages
      kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel
  };


  # Home Manager setup
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = { inherit inputs; };

    users."akki" = { ... }: {
      imports = [
        inputs.hydenix.lib.homeModules
        inputs.nix-index-database.hmModules.nix-index
        ./modules/hm
      ];
    };
  };

  # Enable the Hydenix modules and configure core system settings
  hydenix = {
    enable = true;
    hostname = "nixos";
    timezone = "Asia/Kolkata";
    locale = "en_IN";
  };

  # User configuration
  users.users.akki = {
    isNormalUser = true;
    description = "Akshit Kumar";
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  # Network
  networking.networkmanager.enable = true;

  # Locale & Time
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # X11 (fallback for some apps)
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  # === Optional: Enable SDDM with autologin ===
  # services.displayManager = {
  #   sddm.enable = true;
  #   sddm.wayland.enable = true;
  #   autoLogin.enable = true;
  #   autoLogin.user = "akki";
  #   defaultSession = "hyprland";
  # };

  # Wayland/Hyprland setup
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Wayland/Hyprland session variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # System-wide packages (your preferences)
  environment.systemPackages = with pkgs; [
    home-manager
    zsh
    firefox
    brave
    fastfetch
    neofetch
    hyprpaper
    alacritty
    xfce.thunar
    git
    unzip
    neovim
    vim
    wget
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    dunst
  ];

  networking.firewall.enable = true;

  # This must match your NixOS version at install time
  system.stateVersion = "25.05";
}
