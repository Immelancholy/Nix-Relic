{pkgs, ...}: let
  Nakari = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GcHyQ8DWUAAOAho?format=jpg&name=medium";
    hash = "sha256-YB13taH2jBB6POHniL/muHxCT1Mpir40YgjCkU5Vetc=";
  };

  Goth_Chell = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GXERYazW0AErHbS?format=jpg&name=medium";
    hash = "sha256-OX8v3Xh+sDhgVv6P3leWHHZrIPiVuBrnd9iAoEPtFBQ=";
  };

  Azurenti = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GS9F_-JWMAALb1S?format=jpg&name=medium";
    hash = "sha256-+IdQuGYwOTUwS/B7tMpDf91o3uerAWaXSs4Wn5/jABU=";
  };

  Fubuki = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GJDueQOXsAA7DjN?format=jpg&name=medium";
    hash = "sha256-m7175RBqjgsDb+yNyRkR0AnVp9rvG1nrX7HKpqSJLSU=";
  };

  Shorea = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GG0t0K6bcAA8-xW?format=jpg&name=medium";
    hash = "sha256-NJNpjZUxK+6vvOUJMt/NxkaSA1fUqee7czH+z2f/SU4=";
  };
in {
  home.file = {
    "Pictures/fastfetch_logos/Nakari.jpg" = {
      source = Nakari;
    };
    "Pictures/fastfetch_logos/Goth_Chell.jpg" = {
      source = Goth_Chell;
    };
    "Pictures/fastfetch_logos/Azurenti.jpg" = {
      source = Azurenti;
    };
    "Pictures/fastfetch_logos/Fubuki.jpg" = {
      source = Fubuki;
    };
    "Pictures/fastfetch_logos/Shorea.jpg" = {
      source = Shorea;
    };
  };
}
