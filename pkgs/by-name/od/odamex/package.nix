{
  copyDesktopItems,
  makeDesktopItem,
  lib,
  stdenv,
  fetchurl,
  cmake,
  pkg-config,
  makeWrapper,
  SDL2,
  SDL2_mixer,
  SDL2_net,
  wrapGAppsHook3,
  wxGTK32,
  zlib,
  fltk,
  curl,
  alsa-lib,
  deutex,
}:

stdenv.mkDerivation rec {
  pname = "odamex";
  version = "11.0.0";

  src = fetchurl {
    url = "mirror://sourceforge/${pname}/${pname}-src-${version}.tar.gz";
    hash = "sha256-fk6DrAhUa3eOqeCNWjSoKg9X81Bb3jrUq6JloTwfE4c=";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "odamex";
      desktopName = "Odamex Client";
      categories = ["Game"];
      exec = "odamex";
    })
    (makeDesktopItem {
      name = "odalaunch";
      desktopName = "Odamex Launcher";
      categories = ["Game"];
      exec = "odalaunch";
    })
    (makeDesktopItem {
      name = "odasrv";
      desktopName = "Odamex Server";
      categories = ["Game"];
      exec = "odasrv";
    })
  ];

  nativeBuildInputs = [
    copyDesktopItems
    cmake
    pkg-config
    makeWrapper
    deutex
  ];

  buildInputs = [
    wrapGAppsHook3
    fltk
    zlib
    SDL2
    SDL2_mixer
    SDL2_net
    wxGTK32
    curl
    alsa-lib
  ];

  installPhase =
    ''
      runHook preInstall
    ''
    + (
        ''
          make install
        ''
    )
    + ''
      runHook postInstall
    '';

  meta = {
    homepage = "http://odamex.net/";
    description = "Client/server port for playing old-school Doom online";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.unix;
    maintainers = [ ];
  };
}
