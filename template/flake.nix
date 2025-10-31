# flake.nix
{
  description = "My NixOS and Hom Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-relic = {
      url = "github:Immelancholy/Nix-Relic";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-relic,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      nix-relic = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          nix-relic.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.nur.modules.nixos.default
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.solaar.nixosModules.default
          ./configuration.nix
          ./hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              sharedModules = [
                nix-relic.homeManagerModules.default
                inputs.nixvim.homeManagerModules.nixvim
                inputs.spicetify-nix.homeManagerModules.default
                inputs.artis.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
  };
}
