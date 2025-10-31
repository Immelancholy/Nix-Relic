pkgs: {
  brightness = pkgs.callPackage ./brightness.nix {};
  btop = pkgs.callPackage ./btop.nix {};
  cava = pkgs.callPackage ./cava.nix {};
  cavaCfg = pkgs.callPackage ./cavaCfg.nix {};
  checkshell = pkgs.callPackage ./checkshell.nix {};
  cliphist = pkgs.callPackage ./cliphist.nix {};
  colortrans = pkgs.callPackage ./colortrans.nix {};
  hyprgame = pkgs.callPackage ./hyprgame.nix {};
  mpdchck = pkgs.callPackage ./mpdchck.nix {};
  neo-color = pkgs.callPackage ./neo-color.nix {};
  neo = pkgs.callPackage ./neo.nix {};
  playerVolMPD = pkgs.callPackage ./playerVolMPD.nix {};
  playerVolMpris = pkgs.callPackage ./playerVolMpris.nix {};
  playerVolDefault_Sink = pkgs.callPackage ./playerVolDefault_Sink.nix {};
  rofi-power-menu = pkgs.callPackage ./rofi-power-menu.nix {};
  ss = pkgs.callPackage ./ss.nix {};
  systemd-restarts = pkgs.callPackage ./systemd-restarts.nix {};
  tmux_dev = pkgs.callPackage ./tmux_dev.nix {};
  tmux_nix = pkgs.callPackage ./tmux_nix.nix {};
  tmux_notes = pkgs.callPackage ./tmux_notes.nix {};
  tmux_music = pkgs.callPackage ./tmux_music.nix {};
  toggle-mute = pkgs.callPackage ./toggle-mute.nix {};
  waycava = pkgs.callPackage ./waycava.nix {};
  satty = pkgs.callPackage ./satty.nix {};
  force-hdr = pkgs.callPackage ./hdr.nix {};
}
