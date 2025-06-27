{ ... }:

let
  themes = import ./themes.nix;
in
{
  imports =[
    # ./themes.nix
  ];

  # home-manager options go here
  home.packages = [
    # vscode - hydenix's vscode version
    # userPkgs.vscode - your personal nixpkgs version
  ];

  # hydenix home-manager options go here
  hydenix.hm = {
    #! Important options
    enable = true;
    
    # ! Below are defaults
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = true; # file manager
    editors = {
      enable = true; # enable editors module
      neovim = true; # enable neovim module
      vscode = {
        enable = true; # enable vscode module
        wallbash = true; # enable wallbash extension for vscode
      };
      vim = true; # enable vim module
      default = "code"; # default text editor
    };
    fastfetch.enable = true; # fastfetch configuration
    firefox.enable = false; # enable firefox module
    git = {
      enable = true; # enable git module
      name = "Akshit Kumar"; # git user name eg "John Doe"
      email = "akshit1725@gmail.com"; # git user email eg "john.doe@example.com"
    };
    hyde.enable = true; # enable hyde module
    hyprland = {
      enable = true; # enable hyprland module
      extraConfig = ""; # extra hyprland config text
    };
    lockscreen = {
      enable = true; # enable lockscreen module
      hyprlock = false; # enable hyprlock lockscreen
      swaylock = true; # enable swaylock lockscreen
    };
    notifications.enable = true; # enable notifications module
    qt.enable = true; # enable qt module
    rofi.enable = true; # enable rofi module
    screenshots = {
      enable = true; # enable screenshots module
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false; # enable satty screenshot annotation tool
      swappy.enable = true; # enable swappy screenshot editor
    };
    shell = {
      enable = true; # enable shell module
      zsh = {
        enable = true; # enable zsh shell
        plugins = [ "sudo" ]; # zsh plugins
        configText = ""; # zsh config text
      };
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      pokego.enable = false; # enable Pokemon ASCII art scripts
      p10k.enable = false; # enable p10k prompt
      starship.enable = true; # enable starship prompt
    };
    social = {
      enable = true; # enable social module
      discord.enable = false; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };
    spotify.enable = true; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = true; # enable terminals module
      kitty = {
        enable = true;
        configText = "";
      };
    };
      theme = {
        enable = true; # enable theme module
        active = "Obsidian-Purple"; # active theme name
        themes = [
          "Catppuccin-Latte"
          "Catppuccin-Mocha"
          "Decay-Green"
          "Edge-Runner"
          "Frosted-Glass"
          "Graphite-Mono"
          "Gruvbox-Retro"
          "Green-Lush"
          "Material-Sakura"
          "Nordic-Blue"
          "Obsidian-Purple"
          "Rose-Pine"
          "Synth-Wave"
          "Tokyo-Night"
        ];
      };
      waybar.enable = true; # enable waybar module
      wlogout.enable = true; # enable wlogout module
      xdg.enable = true; # enable xdg module
  };
}
