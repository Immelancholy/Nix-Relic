{
  pkgs,
  inputs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = inputs.nix-relic.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.nix-relic.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };
}
