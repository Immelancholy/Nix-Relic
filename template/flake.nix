# flake.nix
{
  description = "My NixOS and Hom Manager config.";
  inputs = {
    #Default-flakes
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    git-hooks.url = "github:cachix/git-hooks.nix";
    nix-relic = {
      url = "github:Immelancholy/Nix-Relic/stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Override-flakes

    #Added-flakes

    #Non-flakes

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-relic,
      ...
    }:
    let
      inherit (self) inputs outputs;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
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

      packages = forAllSystems ({ pkgs, ... }: import ./pkgs { inherit self; } pkgs);

      nixosModules = import ./modules/nixos;

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        nix-relic = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            nix-relic.nixosModules.default
            ./configuration.nix
            ./hardware-configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                sharedModules = [
                  nix-relic.homeManagerModules.default
                ];
              };
            }
          ];
        };
      };
    };
}
