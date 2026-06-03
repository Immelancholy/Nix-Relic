{
  pkgs,
  ...
}:
let
  associations = {
    "text/plain" = [ "nvim.desktop" ];
    "text/css" = [ "nvim.desktop" ];
    "text/csv" = [ "nvim.desktop" ];
    "text/javascript" = [ "nvim.desktop" ];
    "text/markdown" = [ "nvim.desktop" ];
    "application/json" = [ "nvim.desktop" ];
    "application/xml" = [ "nvim.desktop" ];
    "application/x-shellscript" = [ "nvim.desktop" ];
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
  };
}
