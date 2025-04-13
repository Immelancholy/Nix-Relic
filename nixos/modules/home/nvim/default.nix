{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.programs.nixvim;
in {
  config = mkIf cfg.enable {
    xdg.desktopEntries = {
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        exec = ''nvim'';
        comment = "Edit text files";
        type = "Application";
        terminal = true;
        categories = ["Utility" "TextEditor"];
        icon = "nvim";
        startupNotify = false;
        mimeType = ["text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++"];
        settings = {
          Keywords = "Text;editor";
        };
      };
    };
    programs.zsh = {
      shellAliases = {
        nv = "nvim";
        nvn = "cd $FLAKE_PATH; nv";
      };
    };
    # home.sessionVariables = {
    #   EDITOR = "nvim";
    # };
  };
}
