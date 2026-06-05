{
  pkgs,
  ...
}:
let
  associations = {
    "text/plain" = [ "org.neovim.nvim.desktop" ];
    "text/html" = [ "org.neovim.nvim.desktop" ];
    "text/css" = [ "org.neovim.nvim.desktop" ];
    "text/csv" = [ "org.neovim.nvim.desktop" ];
    "text/javascript" = [ "org.neovim.nvim.desktop" ];
    "text/markdown" = [ "org.neovim.nvim.desktop" ];
    "application/json" = [ "org.neovim.nvim.desktop" ];
    "application/xml" = [ "org.neovim.nvim.desktop" ];
    "application/x-shellscript" = [ "org.neovim.nvim.desktop" ];
    "application/rtf" = [ "org.neovim.nvim.desktop" ];
  };
in
{
  xdg.mimeApps = {
    associations.added = associations;
    defaultApplications = associations;
  };
  home.packages = [
    pkgs.rheayna-vim
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
