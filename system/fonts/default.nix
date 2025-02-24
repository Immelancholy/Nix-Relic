{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      powerline
      powerline-symbols
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.symbols-only
      nerd-fonts.sauce-code-pro
      font-awesome
      roboto
    ];
  };
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["CaskaydiaCove Nerd Font Mono" "JetBrainsMono Nerd Font Mono"];
      serif = ["Noto Serif" "Symbols Only Nerd Font"];
      sansSerif = ["Noto Sans" "Symbols Only Nerd Font"];
      emoji = ["Noto Color Emoji" "Symbols Only Nerd Font"];
    };
  };
}
