{
  inputs,
  pkgs,
  ...
}: let
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "5186af7984aa8cb0550358aefe751201d7a6b5a8";
    hash = "";
  };
in {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    plugins = {
      full-border = "${plugins-repo}/full-border.yazi";
    };
    settings = {
      manager.show_hidden = true;
      opener = {
        edit = [
          {
            run = ''$HOME/.local/share/bin/nv.sh "$@"'';
            block = true;
            desc = ''nvim'';
            for = ''unix'';
          }
        ];
      };
    };
  };
}
