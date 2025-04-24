{
  config,
  lib,
  inputs,
  ...
}: let
  user = config.home.username;
  base = "#${config.lib.stylix.colors.base00}";
  mantle = "#${config.lib.stylix.colors.base01}";
  surface0 = "#${config.lib.stylix.colors.base02}";
  surface1 = "#${config.lib.stylix.colors.base03}";
  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  rosewater = "#${config.lib.stylix.colors.base06}";
  lavender = "#${config.lib.stylix.colors.base07}";
  red = "#${config.lib.stylix.colors.base08}";
  peach = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  teal = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  mauve = "#${config.lib.stylix.colors.base0E}";
  flamingo = "#${config.lib.stylix.colors.base0F}";
in {
  options.stylix.targets.zen = {
    enable = config.lib.stylix.mkEnableTarget "Theme zen" true;
  };
  config = lib.mkIf (config.stylix.enable && config.stylix.targets.zen.enable) {
    home.file.".zen/${user}.Default/chrome/userChrome.css".text = ''
      @media (prefers-color-scheme: dark) {

        :root {
          --zen-colors-primary: ${surface0} !important;
          --zen-primary-color: ${mauve} !important;
          --zen-colors-secondary: ${surface0} !important;
          --zen-colors-tertiary: ${mantle} !important;
          --zen-colors-border: ${mauve} !important;
          --toolbarbutton-icon-fill: ${mauve} !important;
          --lwt-text-color: ${text} !important;
          --toolbar-field-color: ${text} !important;
          --tab-selected-textcolor: ${lavender} !important;
          --toolbar-field-focus-color: ${text} !important;
          --toolbar-color: ${text} !important;
          --newtab-text-primary-color: ${text} !important;
          --arrowpanel-color: ${text} !important;
          --arrowpanel-background: ${base} !important;
          --sidebar-text-color: ${text} !important;
          --lwt-sidebar-text-color: ${text} !important;
          --lwt-sidebar-background-color: #11111b !important;
          --toolbar-bgcolor: ${surface0} !important;
          --newtab-background-color: ${base} !important;
          --zen-themed-toolbar-bg: ${mantle} !important;
          --zen-main-browser-background: ${mantle} !important;
          --toolbox-bgcolor-inactive: ${mantle} !important;
        }

        #permissions-granted-icon{
          color: ${mantle} !important;
        }

        .sidebar-placesTree {
          background-color: ${base} !important;
        }

        #zen-workspaces-button {
          background-color: ${base} !important;
        }

        #TabsToolbar {
          background-color: ${mantle} !important;
        }

        #urlbar-background {
          background-color: ${base} !important;
        }

        .content-shortcuts {
          background-color: ${base} !important;
          border-color: ${mauve} !important;
        }

        .urlbarView-url {
          color: ${mauve} !important;
        }

        #zenEditBookmarkPanelFaviconContainer {
          background: #11111b !important;
        }

        toolbar .toolbarbutton-1 {
          &:not([disabled]) {
            &:is([open], [checked]) > :is(.toolbarbutton-icon, .toolbarbutton-text, .toolbarbutton-badge-stack){
              fill: #11111b;
            }
          }
        }

        .identity-color-blue {
          --identity-tab-color: ${blue} !important;
          --identity-icon-color: ${blue} !important;
        }

        .identity-color-turquoise {
          --identity-tab-color: ${teal} !important;
          --identity-icon-color: ${teal} !important;
        }

        .identity-color-green {
          --identity-tab-color: ${green} !important;
          --identity-icon-color: ${green} !important;
        }

        .identity-color-yellow {
          --identity-tab-color: ${yellow} !important;
          --identity-icon-color: ${yellow} !important;
        }

        .identity-color-orange {
          --identity-tab-color: ${peach} !important;
          --identity-icon-color: ${peach} !important;
        }

        .identity-color-red {
          --identity-tab-color: ${red} !important;
          --identity-icon-color: ${red} !important;
        }

        .identity-color-pink {
          --identity-tab-color: ${flamingo} !important;
          --identity-icon-color: ${flamingo} !important;
        }

        .identity-color-purple {
          --identity-tab-color: ${mauve} !important;
          --identity-icon-color: ${mauve} !important;
        }
      }

    '';
    home.file.".zen/${user}.Default/chrome/userContent.css".text = ''
      @media (prefers-color-scheme: dark) {

        /* Common variables affecting all pages */
        @-moz-document url-prefix("about:") {
          :root {
            --in-content-page-color: ${text} !important;
            --color-accent-primary: ${mauve} !important;
            --color-accent-primary-hover: ${mauve} !important;
            --color-accent-primary-active: rgb(223, 167, 247) !important;
            background-color: ${base} !important;
            --in-content-page-background: ${base} !important;
          }

        }

        /* Variables and styles specific to about:newtab and about:home */
        @-moz-document url("about:newtab"), url("about:home") {

          :root {
            --newtab-background-color: ${base} !important;
            --newtab-background-color-secondary: ${surface0} !important;
            --newtab-element-hover-color: ${surface0} !important;
            --newtab-text-primary-color: ${text} !important;
            --newtab-wordmark-color: ${text} !important;
            --newtab-primary-action-background: ${mauve} !important;
          }

          .icon {
            color: ${mauve} !important;
          }

          .search-wrapper .logo-and-wordmark .logo {
            background: url("zen-logo-mocha.svg"), url("https://raw.githubusercontent.com/IAmJafeth/zen-browser/main/themes/Mocha/Mauve/zen-logo-mocha.svg") no-repeat center !important;
            display: inline-block !important;
            height: 82px !important;
            width: 82px !important;
            background-size: 82px !important;
          }

          @media (max-width: 609px) {
            .search-wrapper .logo-and-wordmark .logo {
              background-size: 64px !important;
              height: 64px !important;
              width: 64px !important;
            }
          }

          .card-outer:is(:hover, :focus, .active):not(.placeholder) .card-title {
            color: ${mauve} !important;
          }

          .top-site-outer .search-topsite {
            background-color: ${blue} !important;
          }

          .compact-cards .card-outer .card-context .card-context-icon.icon-download {
            fill: ${green} !important;
          }
        }

        /* Variables and styles specific to about:preferences */
        @-moz-document url-prefix("about:preferences") {
          :root {
            --zen-colors-tertiary: ${mantle} !important;
            --in-content-text-color: ${text} !important;
            --link-color: ${mauve} !important;
            --link-color-hover: ${mauve} !important;
            --zen-colors-primary: ${surface0} !important;
            --in-content-box-background: ${surface0} !important;
            --zen-primary-color: ${mauve} !important;
          }

          groupbox , moz-card{
            background: ${base} !important;
          }

          button,
          groupbox menulist {
            background: ${surface0} !important;
            color: ${text} !important;
          }

          .main-content {
            background-color: #11111b !important;
          }

          .identity-color-blue {
            --identity-tab-color: ${blue} !important;
            --identity-icon-color: ${blue} !important;
          }

          .identity-color-turquoise {
            --identity-tab-color: ${teal} !important;
            --identity-icon-color: ${teal} !important;
          }

          .identity-color-green {
            --identity-tab-color: ${green} !important;
            --identity-icon-color: ${green} !important;
          }

          .identity-color-yellow {
            --identity-tab-color: ${yellow} !important;
            --identity-icon-color: ${yellow} !important;
          }

          .identity-color-orange {
            --identity-tab-color: ${peach} !important;
            --identity-icon-color: ${peach} !important;
          }

          .identity-color-red {
            --identity-tab-color: ${red} !important;
            --identity-icon-color: ${red} !important;
          }

          .identity-color-pink {
            --identity-tab-color: ${flamingo} !important;
            --identity-icon-color: ${flamingo} !important;
          }

          .identity-color-purple {
            --identity-tab-color: ${mauve} !important;
            --identity-icon-color: ${mauve} !important;
          }
        }

        /* Variables and styles specific to about:addons */
        @-moz-document url-prefix("about:addons") {
          :root {
            --zen-dark-color-mix-base: ${mantle} !important;
            --background-color-box: ${base} !important;
          }
        }

        /* Variables and styles specific to about:protections */
        @-moz-document url-prefix("about:protections") {
          :root {
            --zen-primary-color: ${base} !important;
            --social-color: ${mauve} !important;
            --coockie-color: ${teal} !important;
            --fingerprinter-color: ${yellow} !important;
            --cryptominer-color: ${lavender} !important;
            --tracker-color: ${green} !important;
            --in-content-primary-button-background-hover: ${surface2} !important;
            --in-content-primary-button-text-color-hover: ${text} !important;
            --in-content-primary-button-background: ${surface1} !important;
            --in-content-primary-button-text-color: ${text} !important;
          }


          .card {
            background-color: ${surface0} !important;
          }
        }
      }

    '';
    home.file.".zen/${user}.Default/chrome/zen-logo-mocha.svg" = {
      source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/zen-logo-mocha.svg";
    };
  };
}
