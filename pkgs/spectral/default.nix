{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "spectral";
  version = "2.005";

  src = fetchFromGitHub {
    owner = "productiontype";
    repo = "Spectral";
    rev = "e1179c4fc05c1ba7efd40038e203312b4c90c376";
    hash = "sha256-hoihZUeY8JC0pCnLfTwBAoX1OiTKyG/4B4XeXyc3iVg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/fonts
    cp --recursive fonts/ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = {
    description = "Spectral typeface";
    longDescription = "Spectral is an original typeface designed by Production Type, primarily intended for use inside Google’s Docs and Slides.";
    homepage = "https://github.com/productiontype/Spectral/";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
