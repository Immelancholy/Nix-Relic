{user, ...}: {
  programs.floorp = {
    enable = true;
    languagePacks = [
      "en-gb"
    ];
    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
    profiles.${user} = {
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ];
    };
  };
}
