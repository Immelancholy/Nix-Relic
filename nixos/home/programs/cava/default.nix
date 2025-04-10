{
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 144;
        sensitivity = 100;
        bars = 0;
        bar_width = 1;
        bar_spacing = 0;
      };
      output = {
        method = "noncurses";
        channels = "stereo";
        mono_option = "average";
      };
      smoothing = {
        monstercat = 1;
        waves = 0;
        noise_reduction = 72;
      };
    };
  };
}
