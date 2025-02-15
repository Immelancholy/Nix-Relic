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
			};
			color = {
				gradient_color_1 = "#94e2d5";
				gradient_color_2 = "#89dceb";
				gradient_color_3 = "#74c7ec";
				gradient_color_4 = "#89b4fa";
				gradient_color_5 = "#cba6f7";
				gradient_color_6 = "#f5c2e7";
				gradient_color_7 = "#eba0ac";
				gradient_color_8 = "#f38ba8";
			};
		};
	};
}
