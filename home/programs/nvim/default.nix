{ pkgs, inputs, ... }: {
	programs.nixvim = {
		enable = true;
		colorschemes.catppuccin.enable = true;
		colorscheme = "catppuccin-mocha";
		plugins = {
			lualine.enable = true;
		};
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
		];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	};
}
