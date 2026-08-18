{ pkgs }:

pkgs.appimageTools.wrapType2 rec {
  pname = "zen";
  version = "1.21.12b";

  src = pkgs.fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/${pname}-x86_64.AppImage";
    hash = "sha256-QBqDuJ89iJosIwtcNQtzOkU0EEAb/70J8W5CEBOl1fM=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';
}
