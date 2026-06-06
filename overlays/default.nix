{ self }:
{
  relicpkgs = final: prev: import ./packages { inherit self; } final.pkgs;
  stable = final: prev: {
    stable = import self.inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
  nur = final: prev: {
    nur = self.inputs.nur.overlays.default;
  };
}
