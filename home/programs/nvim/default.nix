{ pkgs, inputs, ... }: {
	programs.nixvim = {
		enable = true;
		colorschemes.catppuccin.enable = true;
		colorscheme = "catppuccin-mocha";
		plugins = {
			lualine.enable = true;
			snacks = {
				enable = true;
				lazyLoad.enable = false;
				autoLoad = true;
				settings = {
					bigfile = {
						enabled = true;
					};
					
				};
			};
		};
		globalOpts = {
			tabstop = 2;
			shiftwidth = 0;
			softtabsop = 0;
		};
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
		];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	};
}
