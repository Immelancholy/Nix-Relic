{
  pkgs,
  config,
  lib,
  ...
}: let
  base = "${config.lib.stylix.colors.base00}";
  mantle = "${config.lib.stylix.colors.base01}";
  surface0 = "${config.lib.stylix.colors.base02}";
  surface1 = "${config.lib.stylix.colors.base03}";
  surface2 = "${config.lib.stylix.colors.base04}";
  text = "${config.lib.stylix.colors.base05}";
  rosewater = "${config.lib.stylix.colors.base06}";
  lavender = "${config.lib.stylix.colors.base07}";
  red = "${config.lib.stylix.colors.base08}";
  peach = "${config.lib.stylix.colors.base09}";
  yellow = "${config.lib.stylix.colors.base0A}";
  green = "${config.lib.stylix.colors.base0B}";
  teal = "${config.lib.stylix.colors.base0C}";
  blue = "${config.lib.stylix.colors.base0D}";
  mauve = "${config.lib.stylix.colors.base0E}";
  flamingo = "${config.lib.stylix.colors.base0F}";

  neo-color = pkgs.writeShellScriptBin "neo-color" ''
    neoDir="$XDG_CONFIG_HOME/neo"
    neoColorFile="$neoDir/colors"

    teal=$(colortrans ${teal} | sed -n '2p' | awk '{print $8}')
    blue=$(colortrans ${blue} | sed -n '2p' | awk '{print $8}')
    lavender=$(colortrans ${lavender} | sed -n '2p' | awk '{print $8}')
    mauve=$(colortrans ${mauve} | sed -n '2p' | awk '{print $8}')
    flamingo=$(colortrans ${flamingo} | sed -n '2p' | awk '{print $8}')
    peach=$(colortrans ${peach} | sed -n '2p' | awk '{print $8}')
    red=$(colortrans ${red} | sed -n '2p' | awk '{print $8}')
    text=$(colortrans ${text} | sed -n '2p' | awk '{print $8}')
    yellow=$(colortrans ${yellow} | sed -n '2p' | awk '{print $8}')

    if [ ! -d "$neoDir" ]; then
      echo "Making Neo Directory"
      mkdir -p "$neoDir"
    fi

    cat >"$neoColorFile" <<EOF
      neo_color_version 1
      -1
      ''${flamingo:11}
      ''${blue:11}
      ''${mauve:11}
      ''${teal:11}
      ''${text:11}
    EOF
  '';

  colortrans =
    pkgs.writers.writePython3Bin "colortrans" {
      doCheck = false;
    } ''

      """
      Convert values between RGB hex codes and xterm-256 color codes.

      Nice long listing of all 256 colors and their codes. Useful for
      developing console color themes, or even script output schemes.

      The legacy version uses naive euclidean distance in rgb space,
      the non-legacy version uses naive euclidean distance in hsv space, manually
      tweaked to work better with low values colors

      Thanks to Micah Elliott for the legacy version that I used in the beginning
      """

      import sys
      import re

      from typing import Tuple, Dict

      __author__ = "Gerry Agbobada (@gagbo)"
      __version__ = "0.1"
      __copyright__ = "Copyright (C) 2019 Gerry Agbobada.  All rights reserved."
      __license__ = "MIT"

      # ---------------------------------------------------------------------


      CLUT = [  # color look-up table
          #    8-bit, RGB hex
          # Primary 3-bit (8 colors). Unique representation!
          # Equivalent "bright" versions of original 8 colors.
          # They are removed because they usually conflict with
          # Terminal emulators colorschemes
          # Strictly ascending.
          ("16", "000000"),
          ("17", "00005f"),
          ("18", "000087"),
          ("19", "0000af"),
          ("20", "0000d7"),
          ("21", "0000ff"),
          ("22", "005f00"),
          ("23", "005f5f"),
          ("24", "005f87"),
          ("25", "005faf"),
          ("26", "005fd7"),
          ("27", "005fff"),
          ("28", "008700"),
          ("29", "00875f"),
          ("30", "008787"),
          ("31", "0087af"),
          ("32", "0087d7"),
          ("33", "0087ff"),
          ("34", "00af00"),
          ("35", "00af5f"),
          ("36", "00af87"),
          ("37", "00afaf"),
          ("38", "00afd7"),
          ("39", "00afff"),
          ("40", "00d700"),
          ("41", "00d75f"),
          ("42", "00d787"),
          ("43", "00d7af"),
          ("44", "00d7d7"),
          ("45", "00d7ff"),
          ("46", "00ff00"),
          ("47", "00ff5f"),
          ("48", "00ff87"),
          ("49", "00ffaf"),
          ("50", "00ffd7"),
          ("51", "00ffff"),
          ("52", "5f0000"),
          ("53", "5f005f"),
          ("54", "5f0087"),
          ("55", "5f00af"),
          ("56", "5f00d7"),
          ("57", "5f00ff"),
          ("58", "5f5f00"),
          ("59", "5f5f5f"),
          ("60", "5f5f87"),
          ("61", "5f5faf"),
          ("62", "5f5fd7"),
          ("63", "5f5fff"),
          ("64", "5f8700"),
          ("65", "5f875f"),
          ("66", "5f8787"),
          ("67", "5f87af"),
          ("68", "5f87d7"),
          ("69", "5f87ff"),
          ("70", "5faf00"),
          ("71", "5faf5f"),
          ("72", "5faf87"),
          ("73", "5fafaf"),
          ("74", "5fafd7"),
          ("75", "5fafff"),
          ("76", "5fd700"),
          ("77", "5fd75f"),
          ("78", "5fd787"),
          ("79", "5fd7af"),
          ("80", "5fd7d7"),
          ("81", "5fd7ff"),
          ("82", "5fff00"),
          ("83", "5fff5f"),
          ("84", "5fff87"),
          ("85", "5fffaf"),
          ("86", "5fffd7"),
          ("87", "5fffff"),
          ("88", "870000"),
          ("89", "87005f"),
          ("90", "870087"),
          ("91", "8700af"),
          ("92", "8700d7"),
          ("93", "8700ff"),
          ("94", "875f00"),
          ("95", "875f5f"),
          ("96", "875f87"),
          ("97", "875faf"),
          ("98", "875fd7"),
          ("99", "875fff"),
          ("100", "878700"),
          ("101", "87875f"),
          ("102", "878787"),
          ("103", "8787af"),
          ("104", "8787d7"),
          ("105", "8787ff"),
          ("106", "87af00"),
          ("107", "87af5f"),
          ("108", "87af87"),
          ("109", "87afaf"),
          ("110", "87afd7"),
          ("111", "87afff"),
          ("112", "87d700"),
          ("113", "87d75f"),
          ("114", "87d787"),
          ("115", "87d7af"),
          ("116", "87d7d7"),
          ("117", "87d7ff"),
          ("118", "87ff00"),
          ("119", "87ff5f"),
          ("120", "87ff87"),
          ("121", "87ffaf"),
          ("122", "87ffd7"),
          ("123", "87ffff"),
          ("124", "af0000"),
          ("125", "af005f"),
          ("126", "af0087"),
          ("127", "af00af"),
          ("128", "af00d7"),
          ("129", "af00ff"),
          ("130", "af5f00"),
          ("131", "af5f5f"),
          ("132", "af5f87"),
          ("133", "af5faf"),
          ("134", "af5fd7"),
          ("135", "af5fff"),
          ("136", "af8700"),
          ("137", "af875f"),
          ("138", "af8787"),
          ("139", "af87af"),
          ("140", "af87d7"),
          ("141", "af87ff"),
          ("142", "afaf00"),
          ("143", "afaf5f"),
          ("144", "afaf87"),
          ("145", "afafaf"),
          ("146", "afafd7"),
          ("147", "afafff"),
          ("148", "afd700"),
          ("149", "afd75f"),
          ("150", "afd787"),
          ("151", "afd7af"),
          ("152", "afd7d7"),
          ("153", "afd7ff"),
          ("154", "afff00"),
          ("155", "afff5f"),
          ("156", "afff87"),
          ("157", "afffaf"),
          ("158", "afffd7"),
          ("159", "afffff"),
          ("160", "d70000"),
          ("161", "d7005f"),
          ("162", "d70087"),
          ("163", "d700af"),
          ("164", "d700d7"),
          ("165", "d700ff"),
          ("166", "d75f00"),
          ("167", "d75f5f"),
          ("168", "d75f87"),
          ("169", "d75faf"),
          ("170", "d75fd7"),
          ("171", "d75fff"),
          ("172", "d78700"),
          ("173", "d7875f"),
          ("174", "d78787"),
          ("175", "d787af"),
          ("176", "d787d7"),
          ("177", "d787ff"),
          ("178", "d7af00"),
          ("179", "d7af5f"),
          ("180", "d7af87"),
          ("181", "d7afaf"),
          ("182", "d7afd7"),
          ("183", "d7afff"),
          ("184", "d7d700"),
          ("185", "d7d75f"),
          ("186", "d7d787"),
          ("187", "d7d7af"),
          ("188", "d7d7d7"),
          ("189", "d7d7ff"),
          ("190", "d7ff00"),
          ("191", "d7ff5f"),
          ("192", "d7ff87"),
          ("193", "d7ffaf"),
          ("194", "d7ffd7"),
          ("195", "d7ffff"),
          ("196", "ff0000"),
          ("197", "ff005f"),
          ("198", "ff0087"),
          ("199", "ff00af"),
          ("200", "ff00d7"),
          ("201", "ff00ff"),
          ("202", "ff5f00"),
          ("203", "ff5f5f"),
          ("204", "ff5f87"),
          ("205", "ff5faf"),
          ("206", "ff5fd7"),
          ("207", "ff5fff"),
          ("208", "ff8700"),
          ("209", "ff875f"),
          ("210", "ff8787"),
          ("211", "ff87af"),
          ("212", "ff87d7"),
          ("213", "ff87ff"),
          ("214", "ffaf00"),
          ("215", "ffaf5f"),
          ("216", "ffaf87"),
          ("217", "ffafaf"),
          ("218", "ffafd7"),
          ("219", "ffafff"),
          ("220", "ffd700"),
          ("221", "ffd75f"),
          ("222", "ffd787"),
          ("223", "ffd7af"),
          ("224", "ffd7d7"),
          ("225", "ffd7ff"),
          ("226", "ffff00"),
          ("227", "ffff5f"),
          ("228", "ffff87"),
          ("229", "ffffaf"),
          ("230", "ffffd7"),
          ("231", "ffffff"),
          # Gray-scale range.
          ("232", "080808"),
          ("233", "121212"),
          ("234", "1c1c1c"),
          ("235", "262626"),
          ("236", "303030"),
          ("237", "3a3a3a"),
          ("238", "444444"),
          ("239", "4e4e4e"),
          ("240", "585858"),
          ("241", "626262"),
          ("242", "6c6c6c"),
          ("243", "767676"),
          ("244", "808080"),
          ("245", "8a8a8a"),
          ("246", "949494"),
          ("247", "9e9e9e"),
          ("248", "a8a8a8"),
          ("249", "b2b2b2"),
          ("250", "bcbcbc"),
          ("251", "c6c6c6"),
          ("252", "d0d0d0"),
          ("253", "dadada"),
          ("254", "e4e4e4"),
          ("255", "eeeeee"),
      ]


      def _strip_hash(hexstring: str) -> str:
          """
          Strip leading `#` if exists.
          """
          if hexstring.startswith("#"):
              hexstring = hexstring.lstrip("#")
          return hexstring


      def hex2rgb(hexstring: str) -> Tuple[int, int, int]:
          """
          Break 6-char RGB code into 3 integer vals.
          """
          rgb = _strip_hash(hexstring)
          red_int, green_int, blue_int = [
              int(h, 16) for h in re.split(r"(..)(..)(..)", rgb)[1:4]
          ]
          return red_int, green_int, blue_int


      def _hex2hsv(hexstring: str) -> Tuple[float, float, float]:
          """
          Return the HSV tuple from a hex string
          >>> _hex2hsv('000000')
          (0.0, 0.0, 0.0)
          >>> _hex2hsv('FFFFFF')
          (0.0, 0.0, 1.0)
          >>> _hex2hsv('FF0000')
          (0.0, 1.0, 1.0)
          >>> _hex2hsv('808000')
          (60.0, 1.0, 0.5)
          """
          rgb_int = hex2rgb(hexstring)
          rgb_f = tuple(map(lambda val: float(val) / 255.0, rgb_int))
          c_min = min(rgb_f)
          c_max = max(rgb_f)
          delta = c_max - c_min

          # Hue
          if delta == 0:
              hue = 0.0
          elif c_max == rgb_f[0]:
              hue = 60.0 * ((rgb_f[1] - rgb_f[2]) / delta % 6)
          elif c_max == rgb_f[1]:
              hue = 60.0 * ((rgb_f[2] - rgb_f[0]) / delta + 2)
          else:
              hue = 60.0 * ((rgb_f[0] - rgb_f[1]) / delta + 4)

          # Saturation
          if c_max == 0:
              sat = 0.0
          else:
              sat = delta / c_max

          # Value
          val = c_max

          return (round(hue, 2), round(sat, 2), round(val, 2))


      def _create_dicts() -> Tuple[
          Dict[str, str],
          Dict[str, str],
          Dict[str, Tuple[float, float, float]],
          Dict[Tuple[float, float, float], str],
      ]:
          short2rgb_dict = dict(CLUT)
          rgb2short_dict = {}
          short2hsv_dict = {}
          hsv2short_dict = {}
          for k, v in short2rgb_dict.items():
              rgb2short_dict[v] = k
              hsv = _hex2hsv(v)
              short2hsv_dict[k] = hsv
              hsv2short_dict[hsv] = k
          return rgb2short_dict, short2rgb_dict, short2hsv_dict, hsv2short_dict


      def short2rgb(short: str) -> str:
          return SHORT2RGB_DICT[short]


      def rgb2short_legacy(hexstring: str) -> Tuple[str, str]:
          """
          Find the closest xterm-256 approximation to the given RGB value.
          @param hexstring: Hex code representing an RGB value, eg, 'abcdef'
          @returns: String between 0 and 255, compatible with xterm.
          >>> rgb2short_legacy('123456')
          ('23', '005f5f')
          >>> rgb2short_legacy('ffffff')
          ('231', 'ffffff')
          >>> rgb2short_legacy('0DADD6') # vimeo logo
          ('38', '00afd7')
          """
          incs = (0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF)
          # Break 6-char RGB code into 3 integer vals.
          parts = hex2rgb(hexstring)
          res_parts = []
          for part in parts:
              i = 0
              while i < len(incs) - 1:
                  s, b = incs[i], incs[i + 1]  # smaller, bigger
                  if s <= part <= b:
                      s1 = abs(s - part)
                      b1 = abs(b - part)
                      closest = s if s1 < b1 else b
                      res_parts.append(closest)
                      break
                  i += 1
                  # print '***', res
          res = "".join([("%02.x" % i) for i in res_parts])
          equiv = RGB2SHORT_DICT[res]
          # print '***', res, equiv
          return equiv, res


      def rgb2short(hexstring: str) -> Tuple[str, str]:
          """
          Find the closest xterm-256 approximation to the given RGB value.
          @param hexstring: Hex code representing an RGB value, eg, 'abcdef'
          @returns: String between 0 and 255, compatible with xterm.
          >>> rgb2short('123456')
          ('17', '00005f')
          >>> rgb2short('ffffff')
          ('231', 'ffffff')
          >>> rgb2short('0DADD6') # vimeo logo
          ('38', '00afd7')
          """
          hsv = _hex2hsv(hexstring)
          result = hsv2short(hsv)
          return result, SHORT2RGB_DICT[result]


      def short2hsv(short: str) -> Tuple[float, float, float]:
          return SHORT2HSV_DICT[short]


      def _hsvdistance(a: Tuple[float, float, float], b: Tuple[float, float, float]) -> float:
          hue_diff = ((a[0] - b[0]) + 180) % 360 - 180
          hue_dist = abs(hue_diff / 360.0) ** 2
          sat_dist = abs(a[1] - b[1]) ** 2
          val_dist = abs(a[2] - b[2]) ** 1
          return hue_dist + sat_dist + val_dist


      def hsv2short(hsv: Tuple[float, float, float]) -> str:
          """
          Return the xterm palette color of the closest candidate in
          hue, saturation and value
          """
          xterm_val, xterm_hsv = min(
              SHORT2HSV_DICT.items(), key=lambda kv_pair: _hsvdistance(kv_pair[1], hsv)
          )
          return xterm_val


      def print_all() -> None:
          """
          Print all 256 xterm color codes.
          """
          for short, rgb in CLUT:
              sys.stdout.write("\033[48;5;%sm%s:%s" % (short, short, rgb))
              sys.stdout.write("\033[0m  ")
              sys.stdout.write("\033[38;5;%sm%s:%s" % (short, short, rgb))
              sys.stdout.write("\033[0m\n")
          print("Printed all codes.")
          print("You can translate a hex or 0-255 code by providing an argument.")


      RGB2SHORT_DICT, SHORT2RGB_DICT, SHORT2HSV_DICT, HSV2SHORT_DICT = _create_dicts()

      # ------------------------------------------------------------------


      if __name__ == "__main__":
          import doctest

          doctest.testmod()
          if len(sys.argv) == 1:
              print_all()
              raise SystemExit
          arg = sys.argv[1]
          if len(arg) < 4 and int(arg) < 256:
              rgb = short2rgb(arg)
              sys.stdout.write(
                  "xterm color \033[38;5;%sm%s\033[0m -> RGB exact "
                  "\033[38;5;%sm%s\033[0m" % (arg, arg, arg, rgb)
              )
              sys.stdout.write("\033[0m\n")
          else:
              arg_rgb = hex2rgb(arg)
              short_legacy, rgb_legacy = rgb2short_legacy(arg)
              short, rgb = rgb2short(arg)
              sys.stdout.write(
                  "(LEGACY) RGB %s \033[38;2;%s;%s;%sm(TRUECOLOR) "
                  "\033[0m-> xterm color approx "
                  "\033[38;5;%sm%s (%s)"
                  % (
                      arg,
                      arg_rgb[0],
                      arg_rgb[1],
                      arg_rgb[2],
                      short_legacy,
                      short_legacy,
                      rgb_legacy,
                  )
              )
              sys.stdout.write("\033[0m\n")
              sys.stdout.write(
                  "RGB %s \033[38;2;%s;%s;%sm(TRUECOLOR) "
                  "\033[0m-> xterm color approx "
                  "\033[38;5;%sm%s (%s)"
                  % (arg, arg_rgb[0], arg_rgb[1], arg_rgb[2], short, short, rgb)
              )
              sys.stdout.write("\033[0m\n")
    '';
in {
  home = {
    activation = {
      neo-color = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run neo-color
      '';
    };
    extraActivationPath = [
      neo-color
      colortrans
      pkgs.gawk
    ];
  };
}
