{
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (config.lib.stylix) colors;
  mkHex = colors: builtins.mapAttrs (_: value: "#${value}") colors;
  colors-hex = mkHex colors;
in
with colors-hex;
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
