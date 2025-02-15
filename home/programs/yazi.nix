{ inputs, pkgs, ... }: {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    plugins = {};
    settings = {
      manager.show_hidden = true;
    };
  };
}
