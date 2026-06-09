{
  description = "Modules and packages for my Nix-Relic template.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    git-hooks.url = "github:cachix/git-hooks.nix";

    rheayna-vim.url = "github:Immelancholy/RheaynaVim";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-easymotion = {
      # url = "github:zakk4223/hyprland-easymotion";
      url = "github:Immelancholy/hyprland-easymotion/nix-shit";
      inputs.hyprland.follows = "hyprland";
    };

    hyprquickframe = {
      url = "github:Ronin-CK/HyprQuickFrame";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zarumet = {
      url = "github:Immelancholy/zarumet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    linktui = {
      url = "github:Immelancholy/linktui/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar = {
      url = "github:buzz/waybar/fix/hyprland-workspaces-scroll";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:Immelancholy/stylix/zen-browser-opacity";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";

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
    zsh-256color = {
      url = "github:chrissicool/zsh-256color";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (self) inputs;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            system = system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      formatter = forAllSystems (
        { pkgs, system }:
        let
          config = self.checks.${system}.pre-commit-check.config;
          inherit (config) package configFile;
          script = ''
            ${pkgs.lib.getExe package} run --all-files --config ${configFile}
          '';
        in
        pkgs.writeShellScriptBin "pre-commit-run" script
      );

      checks = forAllSystems (
        { pkgs, system }:
        {
          pre-commit-check = inputs.git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt.enable = true;

              stylua = {
                enable = true;
                args = [
                  "--indent-type"
                  "Spaces"
                  "--indent-width"
                  "2"
                  "-"
                ];
              };
            };

            package = pkgs.prek;
          };
        }
      );

      devShells = forAllSystems (
        { pkgs, system }:
        {
          default =
            let
              inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
            in
            pkgs.mkShell {
              inherit shellHook;
              buildInputs = enabledPackages;
            };
        }
      );

      overlays = import ./overlays { inherit self; };

      packages = forAllSystems ({ pkgs, ... }: import ./packages { inherit self; } pkgs);

      nixosModules = {
        default = import ./modules/nixos;
      };

      homeManagerModules = {
        default = import ./modules/home-manager;
      };

      templates = {
        default = {
          description = "Goofy stuff";
          path = ./template;
        };
      };
    };
}
