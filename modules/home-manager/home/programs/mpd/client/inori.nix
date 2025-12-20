{
  config,
  inputs,
  pkgs,
  ...
}: let
  base00 = "#${config.lib.stylix.colors.base00}";
  base01 = "#${config.lib.stylix.colors.base01}";
  base02 = "#${config.lib.stylix.colors.base02}";
  base03 = "#${config.lib.stylix.colors.base03}";
  base04 = "#${config.lib.stylix.colors.base04}";
  base05 = "#${config.lib.stylix.colors.base05}";
  base06 = "#${config.lib.stylix.colors.base06}";
  base07 = "#${config.lib.stylix.colors.base07}";
  base08 = "#${config.lib.stylix.colors.base08}";
  base09 = "#${config.lib.stylix.colors.base09}";
  base0A = "#${config.lib.stylix.colors.base0A}";
  base0B = "#${config.lib.stylix.colors.base0B}";
  base0C = "#${config.lib.stylix.colors.base0C}";
  base0D = "#${config.lib.stylix.colors.base0D}";
  base0E = "#${config.lib.stylix.colors.base0E}";
  base0F = "#${config.lib.stylix.colors.base0F}";
in {
  programs.inori = {
    enable = true;
    package = inputs.nix-relic.inputs.inori.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      qwerty_keybindings = true;
      keybindings = {
        seek = [
          "C-l"
          "C-<right>"
        ];
        seek_backwards = [
          "C-h"
          "C-<left>"
        ];
        next_song = [
          "C-j"
          "C-<down>"
        ];
        previous_song = [
          "C-k"
          "C-<up>"
        ];
      };
      theme = {
        item_highlight_active = {
          fg = base00;
          bg = base0E;
        };
        item_highlight_inactive = {
          fg = base05;
        };
        block_active = {
          fg = base0E;
        };
        status_playing = {
          fg = base0C;
        };
        status_paused = {
          fg = base0A;
        };
        status_artist = {
          fg = base08;
        };
        status_album = {
          fg = base0F;
        };
        field_album = {
          fg = base0F;
        };
      };
    };
  };
}
