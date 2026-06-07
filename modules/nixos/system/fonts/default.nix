{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      powerline
      powerline-symbols
      nerd-fonts.caskaydia-cove
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.symbols-only
      nerd-fonts.sauce-code-pro
      nerd-fonts.fira-code
      font-awesome
      roboto
    ];
  };
  fonts.fontconfig = {
    enable = true;
  };
}
