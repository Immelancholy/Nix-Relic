{ pkgs, ... }: {
    
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline
    powerline-symbols
    nerdfonts
  ];
}
