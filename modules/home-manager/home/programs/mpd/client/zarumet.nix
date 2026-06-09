{
  config,
  inputs,
  pkgs,
  ...
}:
let
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
in
{
  imports = [
    inputs.nix-relic.inputs.zarumet.homeModules.default
  ];
  programs.zarumet = {
    enable = true;
    package = pkgs.zarumet;
    settings = {
      mpd = {
        address = "${config.services.mpd.network.listenAddress}:${toString config.services.mpd.network.port}";
      };
      colors = {
        border = base05;
        border_selected = base0E;
        border_title = base0C;
        song_title = base05;
        album = base0F;
        artist = base08;
        progress_filled = base0F;
        progress_empty = base00;
        paused = base0D;
        playing = base0D;
        stopped = base0D;
        time_separator = base0D;
        time_duration = base0D;
        time_elapsed = base0D;
        queue_selected_highlight = base0E;
        queue_selected_text = base00;
        queue_album = base0F;
        queue_song_title = base05;
        queue_song_playing = base0C;
        queue_artist = base08;
        queue_position = base0D;
        queue_duration = base0D;
        top_accent = base0D;
        volume = base0F;
        volume_empty = base00;
        mode = base05;
        track_duration = base0D;
      };
    };
  };
}
