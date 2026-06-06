{ self }:
pkgs: {
  brightness = pkgs.callPackage ./brightness.nix { };
  cava-cfg = pkgs.callPackage ./cava-cfg.nix { };
  checkshell = pkgs.callPackage ./checkshell.nix { };
  rofi-cliphist = pkgs.callPackage ./rofi-cliphist.nix { };
  colortrans = pkgs.callPackage ./colortrans.nix { };
  neo-color = pkgs.callPackage ./neo-color.nix { };
  playerVolMPD = pkgs.callPackage ./playerVolMPD.nix { };
  playerVolMpris = pkgs.callPackage ./playerVolMpris.nix { };
  playerVolDefault_Sink = pkgs.callPackage ./playerVolDefault_Sink.nix { };
  rofi-power-menu = pkgs.callPackage ./rofi-power-menu.nix { };
  toggle-mute = pkgs.callPackage ./toggle-mute.nix { };
  waycava = pkgs.callPackage ./waycava.nix { };
  relic-cli = pkgs.callPackage ./relic-cli.nix { };
  relic-btop = pkgs.callPackage ./relic-btop.nix { };
  relic-cava = pkgs.callPackage ./relic-cava.nix { };
  relic-neo = pkgs.callPackage ./relic-neo.nix { };
  flake-cli = pkgs.callPackage ./flake-cli.nix { };
}
