{
  description = "Modules and packages for my Nix-Relic template.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprquickshot = {
      url = "github:Immelancholy/hyprquickshot/open-screenshot-in-satty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    artis = {
      url = "github:Immelancholy/artis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inori = {
      url = "github:eshrh/inori";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zsh-256color = {
      url = "github:chrissicool/zsh-256color";
      flake = false;
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
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      # inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-easymotion = {
      url = "github:zakk4223/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };
    hy3 = {
      # url = "github:outfoxxed/hy3";
      url = "github:nnra6864/hy3/replace-generateVersion";
      inputs.hyprland.follows = "hyprland";
    };
    stylix.url = "github:Immelancholy/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    overlay = final: prev: {
      nrm = import ./packages final.pkgs;
      stable = import inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = true;
      };
      nur = inputs.nur.overlays.default;
    };
  in {
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays.default = overlay;

    nixosModules.default = import ./modules/nixos/default.nix {inherit inputs outputs;};

    homeManagerModules.default = import ./modules/home-manager/default.nix {inherit inputs outputs;};

    templates = {
      default = {
        description = ''Goofy stuff'';
        path = ./template;
      };
    };
  };
}
