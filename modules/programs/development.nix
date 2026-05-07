{ lib, pkgs, ... }:

let
  globalBuildInputs = with pkgs; [
    cudatoolkit
    udev
    libx11 libxi libxrandr libxcursor libGL libGLU

    xorg.libX11
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor

    glib
    zlib
    openssl
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    clang-tools
    cmake
    ninja
    vcpkg

    xorg.libX11
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor

    mermaid-cli
    texliveFull
    prettier
    cudatoolkit
    gcc14
    bun
    uv
    rustup
    just

    pkg-config
  ];
  programs.nix-ld.libraries = with pkgs; [
    cudatoolkit
    libx11 libxi libxrandr libxcursor libGL libGLU
    udev
    glib
    glibc
    zlib
    openssl
    stdenv.cc.cc.lib
  ];

  environment.sessionVariables = {
    VCPKG_ROOT = "${pkgs.vcpkg}/share/vcpkg";

    CUDA_PATH = "${pkgs.cudatoolkit}";
    CUDA_HOME = "${pkgs.cudatoolkit}";
    CUDAToolkit_ROOT = "${pkgs.cudatoolkit}";
    CUDAFLAGS = "-I${pkgs.cudatoolkit}/include";
    NVCC_PREPEND_FLAGS = "-I${pkgs.cudatoolkit}/include";
    CUDACXX = "${pkgs.cudatoolkit}/bin/nvcc";
    CUDAHOSTCXX = "${pkgs.gcc14}/bin/g++";

    CC = "${pkgs.gcc14}/bin/gcc";
    CXX = "${pkgs.gcc14}/bin/g++";

    LIBRARY_PATH = lib.makeLibraryPath globalBuildInputs + ":/run/opengl-driver/lib";
    PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" globalBuildInputs;
    # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath globalBuildInputs;
  };
}
