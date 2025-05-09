{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "waycava.sh" (builtins.readFile ./Bash/waycava.sh))
    (writeShellScriptBin "rofi-power-menu" (builtins.readFile ./Bash/rofi-power-menu))
  ];
  imports = [
    ./btop.nix
    ./cava.nix
    ./checkshell.nix
    ./cliphist.nix
    ./neo.nix
    ./tmux_dev.nix
    ./tmux_nix.nix
    ./tmux_notes.nix
    ./ss.nix
    ./toggle-mute.nix
    ./cavaCfg.nix
    ./brightness.nix
    ./colortrans.nix
    ./neo-color-cfg.nix
  ];
}
