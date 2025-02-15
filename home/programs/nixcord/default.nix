{
	programs.nixcord = {
		enable = true;
		config = {
			useQuickCss = true;
			themeLinks = [
			"https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css"
			];
			frameless = true;
			plugins = {

			};
		};
	};
}
