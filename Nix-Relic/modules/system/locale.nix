{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config;
in {
  options = {
    locale = mkOption {
      type = types.str;
      default = "";
      example = "en_GB.UTF-8";
      description = "Set system locale";
    };
  };
  config = {
    i18n.defaultLocale = "${cfg.locale}";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "${cfg.locale}";
      LC_IDENTIFICATION = "${cfg.locale}";
      LC_MEASUREMENT = "${cfg.locale}";
      LC_MONETARY = "${cfg.locale}";
      LC_NAME = "${cfg.locale}";
      LC_NUMERIC = "${cfg.locale}";
      LC_PAPER = "${cfg.locale}";
      LC_TELEPHONE = "${cfg.locale}";
      LC_TIME = "${cfg.locale}";
    };
  };
}
