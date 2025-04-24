{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.nixvim;
in {
  config = mkIf (!cfg.enable) {
    programs.nixvim = {
      colorschemes.catppuccin = {
        autoLoad = true;
        enable = true;
        settings = {
          flavour = config.catppuccin.flavor;
          default_integrations = true;
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
            };
            treesitter = true;
          };
          styles = {
            booleans = [
              "bold"
              "italic"
            ];
            conitionals = [
              "bold"
            ];
          };
          term_colors = true;
          transparent_background = true;
        };
      };
      colorscheme = "catppuccin";
    };
  };
}
