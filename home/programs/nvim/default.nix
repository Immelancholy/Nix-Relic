{ pkgs, inputs, ... }: {
	programs.nixvim = {
		enable = true;
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
		];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	};
}
