{ pkgs, fetchFromGitHub }:

pkgs.stdenv.mkDerivation rec {
  name = "mvisor";
  version = "5b2646b25c41a2d3f4152982947d27bc11710069";

  # sources that will be used for our derivation.
  src = fetchFromGitHub {
    owner = "tenclass";
    repo = name;
    rev = version;
    hash = "sha256-9RTo6/XsjLX0EDg6KTcg8lhd1gtENpWlrABKiyvjsKA=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
    cmake
    meson
    gdb
    ninja
  ];

  buildInputs = with pkgs; [
    protobuf
    acpica-tools
    yaml-cpp
    openssl
    zlib
    glib
    pixman
    zstd
    alsa-lib
    SDL2
    virglrenderer
  ];

  configurePhase = ''
    meson setup build -Dsdl=true -Dvgpu=true # SDL is disabled by default
  '';

  buildPhase = ''
    meson compile -C build
  '';

  # see https://nixos.org/nixpkgs/manual/#ssec-install-phase
  # $src is defined as the location of our `src` attribute above
  installPhase = ''
    mkdir -p $out/bin
    cp -r build/mvisor $out/bin/mvisor
  '';
}
