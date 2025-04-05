# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
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
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
    stylix,
    catppuccin,
    home-manager,
    solaar,
    rust-overlay,
    nix-flatpak,
    lanzaboote,
    nur,
    alejandra,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "mela"; # Replace with your username
    git = "Immelancholy"; #Replace with your Git username
    email = "lenalowes0@gmail.com"; # Replace with your Git email
    XDGBin = "/home/${user}/.local/bin"; #XDG_BIN_HOME
    hyprMonitor = ", preferred, auto, 1"; # monitor for hyprland to use, leave this default and then edit it in post install by using hyprctl monitors to find your monitor
    # hyprMonitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8"; #example and also my monitor lol
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user git email XDGBin hyprMonitor;};
        modules = [
          # ./system/secboot.nix # comment this to disable secureboot
          ({pkgs, ...}: {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [rust-overlay.overlays.default];
            environment.systemPackages = with pkgs; [
              (
                rust-bin.selectLatestNightlyWith
                (toolchain:
                  toolchain.default.override {
                    extensions = ["rust-src" "rust-analyzer"];
                  })
              )
            ];
          })
          nur.modules.nixos.default
          lanzaboote.nixosModules.lanzaboote
          nix-flatpak.nixosModules.nix-flatpak
          solaar.nixosModules.default
          catppuccin.nixosModules.catppuccin
          ./system
          ./modules # Comment and uncomment in the default.nix file in the modules folder to change between amd and nvidia drivers

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs user git email XDGBin hyprMonitor;};
            };

            home-manager.users.${user} = {
              imports = [
                stylix.homeManagerModules.stylix
                ./home
                catppuccin.homeModules.catppuccin
                inputs.nixvim.homeManagerModules.nixvim
                inputs.spicetify-nix.homeManagerModules.default
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
