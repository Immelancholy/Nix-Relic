{ pkgs, ... }: {
    
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline
    powerline-symbols
    nerd-fonts.symbols-only
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
  ];
}
