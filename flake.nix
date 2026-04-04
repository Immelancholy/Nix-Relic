{
  description = "Modules and packages for my Nix-Relic template.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zarumet = {
      url = "github:Immelancholy/zarumet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zsh-256color = {
      url = "github:chrissicool/zsh-256color";
      flake = false;
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
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
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprquickframe = {
      url = "github:Ronin-CK/HyprQuickFrame";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-easymotion = {
      # url = "github:zakk4223/hyprland-easymotion";
      url = "github:Immelancholy/hyprland-easymotion/chase_upstream_again";
      inputs.hyprland.follows = "hyprland";
    };
    stylix = {
      url = "github:Immelancholy/stylix";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";

      # Optional but recommended to limit the size of your system closure.
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit self;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    overlay = final: prev: {
      nr = import ./packages final.pkgs;
      stable = import inputs.nixpkgs-stable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
      nur = inputs.nur.overlays.default;
    };
  in {
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays.default = overlay;

    nixosModules = {
      default = import ./modules/nixos;
    };

    homeManagerModules = {
      default = import ./modules/home-manager;
    };

    templates = {
      default = {
        description = ''Goofy stuff'';
        path = ./template;
      };
    };
  };
}
