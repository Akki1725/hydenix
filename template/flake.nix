{
  description = "Hydenix-based NixOS configuration template by Akshit (akki1725)";

  inputs = {
    # Main NixOS package set
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Your fork of the Hydenix framework
    hydenix = {
      url = "github:Akki1725/hydenix";
    };

    # nix-index database for `command-not-found` and `comma`
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, hydenix, nix-index-database, ... }:
    let
      # Set system architecture — adjust if on aarch64
      system = "x86_64-linux";

      # Change to your preferred hostname
      hostname = "nixos";

      # Build system using your Hydenix fork
      hydenixConfig = hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    in {
      nixosConfigurations.${hostname} = hydenixConfig;
      nixosConfigurations.nixos = hydenixConfig;
    };
}
