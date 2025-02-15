{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "Immelancholy";
    repo = "sddm-sugar-candy-mine";
    rev = "3ceecf439da1f4b6ef41e58f543fbd12bd4487b9";
    sha256 = "sha256-UCFR9zwhfUml8pxlSvgyhnoD2mWFGAx3zwQn25o88vo=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}

