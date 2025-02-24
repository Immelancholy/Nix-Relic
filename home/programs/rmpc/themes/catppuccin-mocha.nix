{
  xdg.configFile."rmpc/themes/catppuccin-mocha.ron".text = ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]
    (
        default_album_art_path: None,
        show_song_table_header: true,
        draw_borders: true,
        browser_column_widths: [20, 38, 42],
        background_color: "#1e1e2e",
        text_color: "#cba6f7",
        header_background_color: "#1e1e2e",
        modal_background_color: "#1e1e2e",
        tab_bar: (
            enabled: true,
            active_style: (fg: "#11111b", bg: "#b4befe", modifiers: "Bold"),
            inactive_style: (),
        ),
        highlighted_item_style: (fg: "#cba6f7", modifiers: "Bold"),
        current_item_style: (fg: "#11111b", bg: "#b4befe", modifiers: "Bold"),
        borders_style: (fg: "#89dceb"),
        highlight_border_style: (fg: "#89dceb"),
        symbols: (song: "󰝚", dir: "󰀥", marker: "", ellipsis: "..."),
        progress_bar: (
            symbols: ["=", "⭘", " "],
            track_style: (fg: "#89dceb", bg:"#181825"),
            elapsed_style: (fg: "#89dceb"),
            thumb_style: (fg: "#cba6f7"),
        ),
        scrollbar: (
            symbols: ["│", "█", "▲", "▼"],
            track_style: (fg: "#cba6f7"),
            ends_style: (fg: "#74c7ec"),
            thumb_style: (fg: "#89dceb"),
        ),
        song_table_format: [
            (
                prop: (kind: Property(Artist), style: (fg: "#cdd6f4"),
                    default: (kind: Text("Unknown"), style: (fg: "#cdd6f4"))
                ),
                width: "20%",
            ),
            (
                prop: (kind: Property(Title), style: (fg: "#cdd6f4"),
                    default: (kind: Text("Unknown"), style: (fg: "#cdd6f4"))
                ),
                width: "35%",
            ),
            (
                prop: (kind: Property(Album), style: (fg: "#74c7ec"),
                    default: (kind: Text("Unknown Album"), style: (fg: "#74c7ec"))
                ),
                width: "30%",
            ),
            (
                prop: (kind: Property(Duration), style: (fg: "#cdd6f4"),
                    default: (kind: Text("-"), style: (fg: "#cdd6f4"))
                ),
                width: "15%",
                alignment: Right,
            ),
        ],
        header: (
            rows: [
                (
                    left: [
                        (kind: Text("["), style: (fg: "#89dceb", modifiers: "Bold")),
                        (kind: Property(Status(State)), style: (fg: "#cba6f7", modifiers: "Bold")),
                        (kind: Text("]"), style: (fg: "#89dceb", modifiers: "Bold"))
                    ],
                    center: [
                        (kind: Property(Song(Title)), style: (fg: "#cba6f7", modifiers: "Bold"),
                            default: (kind: Text("No Song"), style: (fg: "#cba6f7", modifiers: "Bold"))
                        )
                    ],
                    right: [
                        (kind: Property(Widget(Volume)), style: (fg: "#cba6f7"))
                    ]
                ),
                (
                    left: [
                        (kind: Property(Status(Elapsed)), style:(fg: "#f9e2af")),
                        (kind: Text(" / "), style:(fg: "#89dceb")),
                        (kind: Property(Status(Duration)), style:(fg: "#f9e2af")),
                        (kind: Text(" ("), style:(fg: "#cdd6f4")),
                        (kind: Property(Status(Bitrate)), style:(fg: "#cdd6f4")),
                        (kind: Text(" kbps)"), style:(fg: "#cdd6f4"))
                    ],
                    center: [
                        (kind: Property(Song(Artist)), style: (fg: "#74c7ec", modifiers: "Bold"),
                            default: (kind: Text("Unknown"), style: (fg: "#74c7ec", modifiers: "Bold"))
                        ),
                        (kind: Text(" - "), style: (fg: "#f9e2af")),
                        (kind: Property(Song(Album)), style: (fg: "#74c7ec"),
                            default: (kind: Text("Unknown Album"), style: (fg: "#74c7ec"))
                        )
                    ],
                    right: [
                        (
                            kind: Property(Widget(States(
                                active_style: (fg: "#f9e2af", modifiers: "Bold"),
                                separator_style: (fg: "#89dceb")))
                            ),
                            style: (fg: "#939ab7")
                        ),
                    ]
                ),
            ],
        ),
        browser_song_format: [
            (
                kind: Group([
                    (kind: Property(Track)),
                    (kind: Text(" ")),
                ])
            ),
            (
                kind: Group([
                    (kind: Property(Artist)),
                    (kind: Text(" - ")),
                    (kind: Property(Title)),
                ]),
                default: (kind: Property(Filename))
            ),
        ],
    )
  '';
}
