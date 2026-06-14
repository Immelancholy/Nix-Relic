{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  mkHex = colors: builtins.mapAttrs (_: value: "#${value}") colors;
  colors-hex = mkHex colors;
in
with colors-hex;
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext /* json */ ''

        {
          "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
          "palette": {
          "white": "#FFFFFF",
          "black": "#0C212F",
          "tan": "${base0C}",
          "teal": "${base03}",
          "plum": "${base01}",
          "blush": "${base0E}",
          "salmon": "${base09}",
          "sky": "${base04}",
          "teal_blue": "${base0F}",
          "behind": "#ef9f76"
          },
          "secondary_prompt": {
            "background": "transparent",
            "foreground": "p:blush",
            "template": "\udb80\udd42 "
          },
          "transient_prompt": {
            "background": "transparent",
            "foreground": "p:blush",
            "template": "\udb80\udd42 "
          },
          "blocks": [
            {
              "alignment": "left",
              "segments": [
                {
                  "background": "p:black",
                  "foreground": "p:white",
                  "leading_diamond": "\ue0b6",
                  "trailing_diamond": "\ue0b0",
                  "style": "diamond",
                  "template": " {{ .Icon }} ",
                  "type": "os"
                },
                {
                  "background": "p:plum",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "style": "diamond",
                  "template": " {{ if .SSHSession }}\ueba9 {{ end }}{{ .UserName }}@{{ .HostName }} ",
                  "type": "session"
                },
                {
                  "background": "p:blush",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "properties": {
                    "style": "folder"
                  },
                  "style": "powerline",
                  "template": "{{if ne \"~\" .PWD}} \udb80\ude4b{{ else }} \udb80\udedc{{ end }} {{ .Path }} ",
                  "type": "path"
                },
                {
                  "background": "p:salmon",
                  "background_templates": [
                    "{{ if or (.Working.Changed) (.Staging.Changed) }}p:behind{{ end }}",
                    "{{ if and (gt .Ahead 0) (gt .Behind 0) }}p:salmon{{ end }}",
                    "{{ if gt .Ahead 0 }}p:salmon{{ end }}",
                    "{{ if gt .Behind 0 }}p:salmon{ end }}"
                  ],
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "properties": {
                    "branch_icon": "",
                    "fetch_stash_count": true,
                    "fetch_status": true,
                    "fetch_upstream_icon": true
                  },
                  "style": "powerline",
                  "template": " <b>~></b> {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Staging.Changed }} \uf4a7 {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                  "type": "git"
                },
                {
                  "background": "p:sky",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "style": "powerline",
                  "template": " \ue718 {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ",
                  "type": "node"
                },
                {
                  "background": "p:teal_blue",
                  "foreground": "p:white",
                  "properties": {
                    "time_format": "15:04"
                  },
                  "style": "diamond",
                  "template": " \u2665 {{ .CurrentDate | date .Format }} ",
                  "trailing_diamond": "\ue0b0",
                  "type": "time"
                }

              ],
              "type": "prompt"
            }
          ],
          "final_space": true,
          "version": 3
        }
      ''
    );
  };
}
