# flake.nix
{
  description = "My NixOS and Hom Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zsh-256color = {
      url = "github:chrissicool/zsh-256color";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    catppuccinZen = {
      url = "github:catppuccin/zen-browser";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
    yamb = {
      url = "github:h-hg/yamb.yazi";
      flake = false;
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swww.url = "github:LGFae/swww";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    hy3 = {
      url = "github:outfoxxed/hy3"; # where {version} is the hyprland release version
      # or "github:outfoxxed/hy3" to follow the development branch.
      # (you may encounter issues if you dont do the same for hyprland)
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    catppuccin,
    home-manager,
    rust-overlay,
    solaar,
    nix-flatpak,
    lanzaboote,
    nur,
    stylix,
    disko,
    ...
  } @ inputs: let
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    system = forAllSystems (system: system);
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    nixosConfigurations = {
      nix-relic-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.default
          stylix.nixosModules.stylix
          nur.modules.nixos.default
          lanzaboote.nixosModules.lanzaboote
          nix-flatpak.nixosModules.nix-flatpak
          solaar.nixosModules.default
          catppuccin.nixosModules.catppuccin
          ./nixos/system
          ./modules/system
          ./hosts/desktop

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
            };
          }
        ];
      };
      nix-relic-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.default
          stylix.nixosModules.stylix
          nur.modules.nixos.default
          lanzaboote.nixosModules.lanzaboote
          nix-flatpak.nixosModules.nix-flatpak
          solaar.nixosModules.default
          catppuccin.nixosModules.catppuccin
          ./nixos/system
          ./modules/system
          ./hosts/laptop

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
            };
          }
        ];
      };
    };
  };
}
