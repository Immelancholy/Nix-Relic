{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic.users;
  user = name: attrs @ {isNormalUser ? true, ...}:
    attrs
    // {
      inherit isNormalUser;
    };
  userOpts = {
    name,
    config,
    ...
  }: {
    options = {
      extraGroups = mkOption {
        apply = groups:
          if config.isNormalUser
          then cfg.defaultGroups ++ groups
          else groups;
      };
      isAdmin = mkEnableOption "Sudo access";
      home-config = mkOption {
        description = "Extra home manager configuration to be defined here";
        type = types.attrs;
        default = {};
      };
    };
    config = {
      extraGroups =
        if config.isAdmin
        then ["wheel"]
        else [];
    };
  };
in {
  options = {
    nix-relic.users = {
      defaultGroups = mkOption {
        description = "Sane default groups";
        type = with types; listOf str;
        default = [
          "networkmanager"
          "video"
          "seat"
        ];
      };
      users = mkOption {
        description = "Users with sane defaults";
        type = with types; attrsOf attrs;
        apply = mapAttrs user;
        default = [];
      };
    };
    users.users = mkOption {
      type = with types; attrsOf (submodule userOpts);
    };
  };
  config.users = {
    users = cfg.users;
  };
}
