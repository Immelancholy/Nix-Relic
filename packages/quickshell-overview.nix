{
  lib,
  self,
  stdenvNoCC,
  makeWrapper,
  quickshell,
  qt6,
  configFile ? "./config.example.json",
  colorFile ? "",
}:
stdenvNoCC.mkDerivation {
  name = "quickshell-overview";
  src = self.inputs.quickshell-overview;

  nativeBuildInputs = [ makeWrapper ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"/share/quickshell/overview
    cp -r . "$out"/share/quickshell/overview/
    cp ${configFile} "$out"/share/quickshell/overview/config.json
    if [ "${colorFile}" != "" ]; then
            cp ${colorFile} "$out"/share/quickshell/overview/common/Appearance.colors.qml
    fi

    mkdir -p "$out"/bin
    makeWrapper ${lib.getExe quickshell} "$out"/bin/overview \
            --add-flags "-p $out/share/quickshell/overview" \
            --set XDG_CONFIG_HOME "$out/share" \
            --prefix PATH : ${
              lib.makeBinPath [
                qt6.qtwayland
              ]
            }

    runHook postInstall
  '';
}
