{pkgs, ... }: {
	programs.nixcord = {
		enable = true;
		discord = {
      package = pkgs.discord-canary;
      vencord = {
        enable = true;
        openASAR.enable = true;
        vencord.unstable = true;
      };
    };
		config = {
			useQuickCss = true;
			themeLinks = [
			"https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css"
			];
			frameless = true;
		};
    vencordConfig = {
      plugins = {
        fakeNitro.enable = true;
        banger.enable = true;
        blurNSFW.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        crashHandler.enable = true;
        disableCallIdle.enable = true;
        experiments.enable = true;
        fixCodeBlockGap.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        friendsSince.enable = true;
        gameActivityToggle.enable = true;
        gifPaste.enable = true;
        messageLogger.enable = true;
        moreCommands.enable = true;
        moreKaomoji.enable = true;
        moyazi.enable = true;
        mutualGroups.enable = true;
        oneko.enable = true;
        openInApp.enable = true;
        permissionsViewer.enable = true;
        petpet.enable = true;
        pinDMs.enable = true;
        platformIndicators.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
      };
    };
	};
}
