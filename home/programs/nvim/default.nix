{ pkgs, inputs, ... }: {
	programs.nixvim = {
		enable = true;
		colorschemes.catppuccin.enable = true;
		colorscheme = "catppuccin-mocha";
		vimAlias = true;
		withNodeJs = true;
		withPerl = true;
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
					notifier = {
						enabled = true;
						timeout = 3000;
					};
					quickfile = {
						enabled = false;
					};
					statuscolumn = {
						enabled = false;
					};
					words = {
						debounce = 100;
						enabled = true;
					};
					dashboard = {
						enabled = true;
					};
					explorer = {
						enabled = true;
					};
					indent = {
						enabled = true;
					};
					picker = {	
						enabled = true;
					};
				};
			};
			blink-cmp = {
				enable = true;
			};
			treesitter.enable = true;
			nix.enable = true;
			nix-develop.enable = true;

		};
		opts = {
			tabstop = 2;
			shiftwidth = 0;
		};
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
		];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	};
}
