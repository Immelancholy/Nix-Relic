# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    nixcord.url = "github:kaylorben/nixcord";
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
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    swww.url = "github:LGFae/swww";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };



  outputs = inputs@{ self, nixpkgs, nixos-hardware, catppuccin, home-manager, yazi, solaar, nvf, ... }: {
    nixosConfigurations = { 
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          inherit self;
        };
        modules = [
	  solaar.nixosModules.default
          ./system
          catppuccin.nixosModules.catppuccin
	  nixos-hardware.nixosModules.lenovo-legion-t526amr5


          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs; 
                inherit self;
              };
            };

            # TODO replace ryan with your own username ;
            home-manager.users.mela = {
              imports = [
                ./home
                catppuccin.homeManagerModules.catppuccin
                inputs.nixcord.homeManagerModules.nixcord
		nvf.homeManagerModules.default
              ];
            };
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}

