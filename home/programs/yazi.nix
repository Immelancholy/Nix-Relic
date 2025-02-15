{ inputs, pkgs, ... }: {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    plugins = {};
    settings = {
      manager.show_hidden = true;
      opener = {
        edit = [
          { run = ''$HOME/.local/share/bin/kitty_nvim.sh "$@"''; block = true; desc = ''nvim''; for = ''unix''; } 
	];
      };
    };
  };
}
