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
      input = {
        method = "pipewire";
        source = "44";
        sample_rate = 48000;
        sample_bits = 32;
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
