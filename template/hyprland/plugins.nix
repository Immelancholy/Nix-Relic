{
  nix-relic,
  config,
  pkgs,
  ...
}:
let
  inherit (nix-relic) inputs;
  colors = config.lib.stylix.colors;
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
  # easymotion = "${
  #   inputs.hyprland-easymotion.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion
  # }/lib/libhyprland-easymotion.so";
  csgo-vulkan = "${
    inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix
  }/lib/libcsgo-vulkan-fix.so";
in
with colors;
{
  xdg.configFile."hypr/plugins.lua".text = /* Lua */ ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("hyprctl plugin load ${csgo-vulkan}")
    end)
    hl.permission({
      binary = "/nix/store/[a-z0-9]{32}-csgo-vulkan-fix-[0-9.]*/lib/libcsgo-vulkan-fix.so",
      type = "plugin",
      mode = "allow",
    })
    -- hl.permission({
    --   binary = "/nix/store/[a-z0-9]{32}-hyprland-easymotion/lib/libhyprland-easymotion.so",
    --   type = "plugin",
    --   mode = "allow",
    -- })

    -- hl.config({
    --   plugin = {
    --     easymotion = {
    --       textcolor = "${rgb base05}",
    --       bgcolor = "${rgba base00 "bb"}",
    --       bordercolor = {
    --         colors = { "${rgb base0E}", "${rgb base0C}", "${rgb base06}" },
    --         angle = 40,
    --       },
    --       blur = 1,
    --       textpadding = 8,
    --       textsize = 35,
    --       bordersize = 2,
    --       fullscreen_action = "maximize",
    --     },
    --   },
    -- })

    -- hl.bind(mod .. " + D", function() hl.plugin.easymotion.action("hyprctl dispatch 'hl.dsp.focus({ window = \"{}\" })'") end))
  
'';
}
