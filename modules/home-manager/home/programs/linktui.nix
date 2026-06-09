{ nix-relic, ... }:
{
  imports = [
    nix-relic.inputs.linktui.homeModules.default
  ];
  programs.linktui = {
    enable = true;
    package = null;
    settings = {
      window = {
        width = 75;
        height = 27;
      };
    };
  };
}
