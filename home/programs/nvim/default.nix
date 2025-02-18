{ pkgs, inputs, ... }: {
	programs.nixvim = {
		enable = true;
		colorscheme = "catppuccin-mocha";
		plugins = {
			which-key.enable = true;
			snacks.enable = true;
			blink-cmp.enable = true;
		};
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
		];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	};
}
