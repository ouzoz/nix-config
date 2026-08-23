{ pkgs }:

let
  inherit (pkgs.stdenv.hostPlatform) system isLinux isDarwin;

  pname = "helium";
  version = "0.15.6.1";

  meta = {
    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };

  url = repo: asset: "https://github.com/imputnet/${repo}/releases/download/${version}/${asset}";

  release =
    {
      x86_64-linux = {
        url = url "helium-linux" "${pname}-${version}-x86_64.AppImage";
        hash = "sha256-OqXMEZOoFu6NZAozde3ApjNWcvivIItIyeG0HbADpDU=";
      };
      aarch64-linux = {
        url = url "helium-linux" "${pname}-${version}-arm64.AppImage";
        hash = "sha256-J10Xxl1Ks7JPp4tC3/ObayNsqgxkU7FpWRhnE439LUc=";
      };
      aarch64-darwin = {
        url = url "helium-macos" "${pname}_${version}_arm64-macos.dmg";
        hash = "sha256-medoiZEkXGXVDSc1LP6t/aU1DrtkqtQOtHGDPN8yPXk=";
      };
    }
    .${system} or (throw "Helium is unsupported on ${system}");

  src = pkgs.fetchurl release;
in
if isLinux then
  pkgs.appimageTools.wrapType2 {
    inherit
      pname
      version
      src
      meta
      ;

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
else if isDarwin then
  pkgs.stdenvNoCC.mkDerivation {
    inherit
      pname
      version
      src
      meta
      ;

    nativeBuildInputs = [ pkgs.undmg ];
    sourceRoot = ".";

    installPhase = ''
      mkdir -p "$out/Applications"
      cp -R *.app "$out/Applications/"
    '';

  }
else
  throw "Helium is unsupported on ${system}"
