{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
  alpha = "cc";
in
with colors;
{
  xdg.configFile."hypr/colors.lua".text = /* Lua */ ''
    Base00 = "${rgb base00}"
    Base01 = "${rgb base01}"
    Base02 = "${rgb base02}"
    Base03 = "${rgb base03}"
    Base04 = "${rgb base04}"
    Base05 = "${rgb base05}"
    Base06 = "${rgb base06}"
    Base07 = "${rgb base07}"
    Base08 = "${rgb base08}"
    Base09 = "${rgb base09}"
    Base0A = "${rgb base0A}"
    Base0B = "${rgb base0B}"
    Base0C = "${rgb base0C}"
    Base0D = "${rgb base0D}"
    Base0E = "${rgb base0E}"
    Base0F = "${rgb base0F}"
    RgbaBase00 = "${rgba base00 alpha}"
    RgbaBase01 = "${rgba base01 alpha}"
    RgbaBase02 = "${rgba base02 alpha}"
    RgbaBase03 = "${rgba base03 alpha}"
    RgbaBase04 = "${rgba base04 alpha}"
    RgbaBase05 = "${rgba base05 alpha}"
    RgbaBase06 = "${rgba base06 alpha}"
    RgbaBase07 = "${rgba base07 alpha}"
    RgbaBase08 = "${rgba base08 alpha}"
    RgbaBase09 = "${rgba base09 alpha}"
    RgbaBase0A = "${rgba base0A alpha}"
    RgbaBase0B = "${rgba base0B alpha}"
    RgbaBase0C = "${rgba base0C alpha}"
    RgbaBase0D = "${rgba base0D alpha}"
    RgbaBase0E = "${rgba base0E alpha}"
    RgbaBase0F = "${rgba base0F alpha}"
  '';
}
