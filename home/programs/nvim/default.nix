{ pkgs, inputs, ... }: {
	nixpkgs = {
		overlays =  [
      			inputs.neovim-nightly-overlay.overlay
   		 ];
	};
	programs.nixvim = {
		enable = true;
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
		];
		package = pkgs.neovim-nightly;
	};
}
