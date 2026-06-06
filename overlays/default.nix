{ self }:
{
  default =
    final: prev:
    import ./packages { inherit self; } final.pkgs {
      stable = import self.inputs.nixpkgs-stable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
      nur = self.inputs.nur.overlays.default;
    };
}
