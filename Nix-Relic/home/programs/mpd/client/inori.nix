{pkgs, ...}: {
  home.packages = with pkgs; [
    inori
  ];
  xdg.configFile."inori/config.toml".text = ''
    qwerty_keybindings = true

    [theme.item_highlight_active]
    fg = "#11111b"
    bg = "#cba6f7"

    [theme.item_highlight_inactive]
    fg = "#cdd6f4"

    [theme.block_active]
    fg = "#cba6f7"

    [theme.playing]
    fg = "#cba6f7"
    add_modifier = "HIDDEN"

    [theme.status_artist]
    fg = "#89dceb"
    add_modifier = "HIDDEN"

    [theme.status_album]
    fg = "#cba6f7"
    add_modifier = "HIDDEN"

    [theme.album]
    fg = "#cba6f7"
  '';
}
