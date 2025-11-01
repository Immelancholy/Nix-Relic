{
  writeShellScriptBin,
  playerCmd ? ''uwsm app -- kitty --class "mpd" --session=mpd'',
  playerClass ? "mpd",
}:
writeShellScriptBin "launches.sh" ''
  hyprctl dispatch signalwindow 'class:(${playerClass}),9'
  hyprctl dispatch signalwindow 'class:(neo),9'
  hyprctl dispatch signalwindow 'class:(fastfetch),9'
  hyprctl dispatch signalwindow 'class:(btop),9'
  hyprctl dispatch signalwindow 'class:(cava),9'
  hyprctl dispatch exec '[workspace 1 silent; float; size 888 462; move 610 609] uwsm app -- kitty --class "cava" cava.sh'
  hyprctl dispatch exec '[workspace 1 silent; float; size 590 637; move 10 433] uwsm app -- kitty --class "btop" btop.sh'
  hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 42]  uwsm app -- kitty --class "neo" neo.sh'
  hyprctl dispatch exec '[workspace 1 silent; float; size 590 383; move 10 42] uwsm app -- kitty --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"'
  hyprctl dispatch exec '[workspace 1 silent; float; size 888 559; move 610 42] ${playerCmd}'
''
