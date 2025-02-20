{
  services.easyeffects = {
    enable = true;
    preset = "Rode NT1";
  };
  xdg.configFile."easyeffects/input" = {
    source = ./presets/input;
    recursive = true;
  };
}
