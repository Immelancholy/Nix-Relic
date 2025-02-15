{ pkgs, ... }: {
	programs.nixcord = {
		enable = true;
		package = pkgs.discord-canary;
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
