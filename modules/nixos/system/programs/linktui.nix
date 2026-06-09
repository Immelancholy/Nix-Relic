{ pkgs, ... }:
{
  programs.linktui = {
    enable = true;
    package = pkgs.linktui;
  };
}
