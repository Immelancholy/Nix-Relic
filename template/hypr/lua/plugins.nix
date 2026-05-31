{
  nix-relic,
  pkgs,
  ...
}: let
  inherit (nix-relic) inputs;
  easymotion = "${inputs.hyprland-easymotion.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion}/lib/libhyprland-easymotion.so";
  csgo-vulkan = "${inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix}/lib/libcsgo-vulkan-fix.so";
in {
  xdg.configFile."hypr/lua/plugins.lua".text =
    /*
    Lua
    */
    ''
      -- hl.on("hyprland.start", function()
      -- 	hl.exec_cmd(
      -- 		"hyprctl plugin load ${easymotion}"
      -- 	)
      -- 	hl.exec_cmd(
      -- 		"hyprctl plugin load ${csgo-vulkan}"
      -- 	)
      -- end)
      -- hl.permission({
      -- 	binary = "/nix/store/[a-z0-9]{32}-csgo-vulkan-fix-[0-9.]*/lib/libcsgo-vulkan-fix.so",
      -- 	type = "plugin",
      -- 	mode = "allow",
      -- })
      -- hl.permission({
      -- 	binary = "/nix/store/[a-z0-9]{32}-hyprland-easymotion/lib/libhyprland-easymotion.so",
      -- 	type = "plugin",
      -- 	mode = "allow",
      -- })
    '';
}
