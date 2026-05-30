{config, ...}: let
  mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

  mkExtensionEntry = {
    id,
    pinned ? false,
  }: let
    base = {
      install_url = mkPluginUrl id;
      installation_mode = "force_installed";
    };
  in
    if pinned
    then base // {default_area = "navbar";}
    else base;

  mkExtensionSettings = builtins.mapAttrs (_: entry:
    if builtins.isAttrs entry
    then entry
    else mkExtensionEntry {id = entry;});

  user = config.home.username;
in {
  imports = [
    inputs.nix-relic.inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    enablePrivateDesktopEntry = true;
    profiles."${user}.Default".mods = [
      "642854b5-88b4-4c40-b256-e035532109df" #transparent
      "599a1599-e6ab-4749-ab22-de533860de2c" #pimp pip
      "a6335949-4465-4b71-926c-4a52d34bc9c0" #better find bar
      "906c6915-5677-48ff-9bfc-096a02a72379" #floating status
    ];
    policies.ExtensionSettings = mkExtensionSettings {
      "adnauseam@rednoise.org" = mkExtensionEntry {
        id = "adnauseam";
        pinned = true;
      };
      "@crw-extension-firefox" = "consumer-rights-wiki";
      "firefox@tampermonkey.net" = "tampermonkey";
      "vimium-c@gdh1995.cn" = "vimium-c";
      "{91aa3897-2634-4a8a-9092-279db23a7689}" = "zen-internet";
      "sheetkeys@github.com" = "sheetkeys";
      "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
      "{d66c8515-1e0d-408f-82ee-2682f2362726}" = "iina-open-in-mpv";
    };
  };
}
